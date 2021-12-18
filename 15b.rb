values = if ARGV.first == 'frd'
  [883, 879]
else
  [65, 8921]
end

factors = [16807, 48271]

matches = 0
5_000_000.times do
  while (values[0] & 3) != 0
    values[0] = (values[0] * factors[0]) % 0x7fffffff
  end

  while (values[1] & 7) != 0
    values[1] = (values[1] * factors[1]) % 0x7fffffff
  end

  matches += 1 if (values[0] & 0xffff) == (values[1] & 0xffff)
  2.times { |i| values[i] = (values[i] * factors[i]) % 0x7fffffff }
end

puts matches
