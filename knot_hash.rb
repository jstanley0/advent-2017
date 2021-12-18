def reverse_elements(list, pos, length)
  tmp = []
  for i in 0...length
    tmp << list[(pos + i) % list.size]
  end
  for i in 0...length
    list[(pos + i) % list.size] = tmp[length - i - 1]
  end
end

def knot_hash(input)
  lengths = input.chars.map(&:ord)
  lengths.concat([17, 31, 73, 47, 23])

  list = (0..255).to_a
  pos = 0
  skip = 0

  64.times do
    lengths.each do |length|
      reverse_elements(list, pos, length)
      pos = (pos + length + skip) % list.size
      skip += 1
    end
  end

  list.each_slice(16).map { |slice| slice.inject(:^) }
end
