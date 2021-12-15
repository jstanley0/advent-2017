def valid_phrase?(words)
  words.map! { |word| word.chars.sort.join }
  words.size == words.uniq.size
end

puts ARGF.lines.map { |line|
  words = line.split
  valid_phrase?(words) ? 1 : 0
}.sum
