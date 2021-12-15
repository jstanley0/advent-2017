Inst = Struct.new(:dreg, :op, :incval, :creg, :cond, :cval)
program = ARGF.lines.map do |line|
  Inst.new(*line.match(/([a-z]+) (inc|dec) (\-?[0-9]+) if ([a-z]+) (<|<=|>|>=|==|!=) (\-?[0-9]+)/).to_a[1..]).tap do |inst|
    raise "onoz" if inst.cval.nil?
    inst.incval = inst.incval.to_i
    inst.incval *= -1 if inst.op == 'dec'
    inst.cval = inst.cval.to_i
  end
end

regs = {}
top = 0
program.each do |inst|
  regs[inst.creg] ||= 0
  if eval("regs[inst.creg] #{inst.cond} #{inst.cval}")
    regs[inst.dreg] ||= 0
    regs[inst.dreg] += inst.incval
    top = [regs[inst.dreg], top].max
  end
end

puts regs.values.max
puts top
