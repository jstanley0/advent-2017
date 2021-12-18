require_relative 'knot_hash'
require_relative "../2021/skim"

input = ARGV.first
disk = Skim.new(128, 128)

used = 0
(0..127).each do |row|
  hash = knot_hash("#{input}-#{row}")
  hash.each_with_index do |byte, i|
    (0..7).each do |bit|
      used += 1 if byte[bit] == 1
      disk[i * 8 + (7 - bit), row] = byte[bit]
    end
  end
end
puts used

def mark_region(disk, x, y)
  disk[x, y] = nil
  disk.nabes(x, y, diag: false) do |val, a, b|
    mark_region(disk, a, b) if val == 1
  end
end

num_regions = 0
loop do
  x, y = disk.find_coords(1)
  break if x.nil?

  num_regions += 1
  mark_region(disk, x, y)
end
puts num_regions
