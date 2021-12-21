require_relative '../2021/skim'

image = Skim.from_concise_string(".#./..#/###")

Rule = Struct.new(:in, :out)
rules = ARGF.lines.map do |line|
  Rule.new(*line.chomp.split(" => ").map { |str| Skim.from_concise_string(str) })
end
rules = rules.group_by { |rule| rule.in.width }

def create_art(image, rules)
  if image.width % 2 == 0
    elt = 2
    oot = 3
  elsif image.width % 3 == 0
    elt = 3
    oot = 4
  else
    raise "lies"
  end
  hw = image.width / elt
  out = Skim.new(hw * oot, hw * oot)
  hw.times do |x|
    hw.times do |y|
      chunk = image.subset(x * elt, y * elt, elt, elt)
      rule = rules[elt].detect { |r| r.in.match_rotation_of?(chunk) || r.in.match_rotation_of?(chunk.flip_v) }
      out.paste(x * oot, y * oot, rule.out) if rule
    end
  end
  out
end

18.times do |i|
  image = create_art(image, rules)
  puts "#{i + 1}. #{image.width} #{image.flatten.count { |e| e == '#' }}"
end
