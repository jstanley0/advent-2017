values = if ARGV.first == 'frd'
  [883, 879]
else
  [65, 8921]
end

factors = [16807, 48271]

matches = 0
40_000_000.times do
  2.times do |gen|
    values[gen] = (values[gen] * factors[gen]) % 0x7fffffff
  end
  matches += 1 if (values[0] & 0xffff) == (values[1] & 0xffff)
end

puts matches
