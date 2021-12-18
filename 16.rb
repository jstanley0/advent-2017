dance = ARGF.gets.chomp.split(",")
progs = ('a'..'p').to_a

hmap = {}
(1..100).each do |i|
  dance.each do |move|
    case move[0]
    when 's'
      progs = progs.rotate(-move[1..].to_i)
    when 'x'
      a, b = move[1..].split("/").map(&:to_i)
      progs[a], progs[b] = progs[b], progs[a]
    when 'p'
      p, q = move[1..].split("/")
      a, b = progs.index(p), progs.index(q)
      progs[a], progs[b] = progs[b], progs[a]
    end
  end
  perm = progs.join
  if hmap.key?(perm)
    puts "** previously found at #{hmap[perm]}"
  else
    hmap[perm] = i
  end
  puts "#{i}. #{perm}"
end

#puts ('a'..'p').map { |a| progs.index(a) }.inspect
