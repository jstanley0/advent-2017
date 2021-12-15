nums = ARGF.gets.chomp.chars.map(&:to_i)
s = 0
nums.each_with_index do |n, i|
  s += n if n == nums[(i + nums.size / 2) % nums.size]
end
puts s
