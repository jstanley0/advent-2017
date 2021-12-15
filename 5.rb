jumps = ARGF.lines.map(&:to_i)

pc = 0
t = 0
loop do
  old_pc = pc
  pc += jumps[pc]
  t += 1
  if jumps[old_pc] >= 3
    jumps[old_pc] -= 1
  else
    jumps[old_pc] += 1
  end
  break if pc < 0 || pc >= jumps.size
end

puts t
