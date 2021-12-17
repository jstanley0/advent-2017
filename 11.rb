dirs = ARGF.gets.chomp.split(",")

q = 0
r = 0
max_dist = 0
dirs.each do |dir|
  case dir
  when 'n'
    r -= 1
  when 'ne'
    q += 1
    r -= 1
  when 'se'
    q += 1
  when 's'
    r += 1
  when 'sw'
    q -= 1
    r += 1
  when 'nw'
    q -= 1
  end
  s = -q - r
  dist = [q, r, s].map(&:abs).max
  max_dist = [dist, max_dist].max
end

puts max_dist
