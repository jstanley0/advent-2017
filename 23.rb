Inst = Struct.new(:opcode, :x, :y)

program = ARGF.lines.map do |line|
  Inst.new(*line.chomp.split).tap do |inst|
    inst.x = inst.x.to_i unless inst.x =~ /[a-z]+/
    inst.y = inst.y.to_i unless inst.y.nil? || inst.y =~ /[a-z]+/
  end
end

class Computer
  def initialize(program, program_id, regs = {})
    @program = program
    @ip = 0
    @regs = {'p' => program_id}.merge(regs)
    @rx_queue = []
    @tx_queue = nil
    @sent = 0
    @need_input = false
    @terminated = false
    @program_id = program_id
    @mulcount = 0
  end

  def link(other)
    @tx_queue = other.instance_variable_get(:@rx_queue)
    other.instance_variable_set(:@tx_queue, @rx_queue)
  end

  def rvalue(reg_or_value)
    return reg_or_value if reg_or_value.is_a?(Integer)
    @regs[reg_or_value] ||= 0
  end

  def run
    while @ip >= 0 && @ip < @program.size
      inst = @program[@ip]
      print "#{@ip}. #{inst.opcode} #{inst.x} #{inst.y}"
      case inst.opcode
      when 'snd'
        @tx_queue << rvalue(inst.x)
        puts "#{@program_id} sent #{@tx_queue.last}"
        @sent += 1
      when 'set'
        @regs[inst.x] = rvalue(inst.y)
      when 'add'
        @regs[inst.x] ||= 0
        @regs[inst.x] += rvalue(inst.y)
      when 'sub'
        @regs[inst.x] ||= 0
        @regs[inst.x] -= rvalue(inst.y)
      when 'mul'
        @regs[inst.x] ||= 0
        @regs[inst.x] *= rvalue(inst.y)
        @mulcount += 1
      when 'mod'
        @regs[inst.x] ||= 0
        @regs[inst.x] %= rvalue(inst.y)
      when 'rcv'
        if @rx_queue.empty?
          puts "#{@program_id} waiting for input"
          @need_input = true
          puts @regs.inspect
          return
        else
          puts "#{@program_id} received #{@rx_queue.first}"
          @regs[inst.x] = @rx_queue.shift
          @need_input = false
        end
      when 'jgz'
        @ip += rvalue(inst.y) - 1 if rvalue(inst.x) > 0
      when 'jnz'
        @ip += rvalue(inst.y) - 1 if rvalue(inst.x) != 0
      end
      @ip += 1
      puts @regs.inspect
    end
    @terminated = true
  end

  def stats
    "#{@program_id}: sent=#{@sent} mul=#{@mulcount}"
  end

  def need_input?
    @need_input && @rx_queue.empty?
  end

  def terminated?
    @terminated
  end
end

comp0 = Computer.new(program, 0, {'a' =>0})
comp0.run
puts comp0.stats

