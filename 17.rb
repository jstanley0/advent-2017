step = ARGV.first.to_i
cbuf = [0]
pos = 0
val = 1
2018.times do
#  puts cbuf.each_with_index.map { |v, i| i == pos ? "(#{v})" : v }.join(" ")
  pos = (pos + step) % cbuf.size + 1
  cbuf.insert pos, val
  val += 1
end

puts cbuf[cbuf.index(2017) + 1]
