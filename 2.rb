def quotient(nums)
  nums.each_with_index do |n, i|
    nums.each_with_index do |m, j|
      return n / m if i != j && n / m > 0 && n % m == 0
    end
  end
  raise "wat"
end

puts ARGF.lines.map { |line|
  nums = line.split.map(&:to_i)
  #nums.max - nums.min
  quotient(nums)
}.sum

