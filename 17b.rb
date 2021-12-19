step = ARGV.first.to_i
cbuf = [0, 0]
pos = 0
val = 1
50000001.times do
  pos = (pos + step) % val + 1
  cbuf[1] = val if pos == 1
  val += 1
end

puts cbuf.inspect
