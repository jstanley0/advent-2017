banks = ARGF.gets.split.map(&:to_i)

def balance(banks)
  banks = banks.dup
  n, i = banks.each_with_index.max_by { |t| t[0] }
  banks[i] = 0
  while n > 0
    i = (i + 1) % banks.size
    banks[i] += 1
    n -= 1
  end
  banks
end

seen_states = {}
iterations = 0
until seen_states.key?(banks)
  seen_states[banks] = iterations
  banks = balance(banks)
  iterations += 1
end
puts iterations
puts iterations - seen_states[banks]
