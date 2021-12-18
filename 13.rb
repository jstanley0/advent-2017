Scanner = Struct.new(:size, :pos, :dir)

firewall = ARGF.lines.inject({}) do |h, line|
  depth, range = line.split(":").map(&:to_i)
  h[depth] = Scanner.new(range, 0, 1)
  h
end

severity = 0
(firewall.keys.min..firewall.keys.max).each do |depth|
  if firewall[depth] && firewall[depth].pos == 0
    puts "caught on layer #{depth}"
    severity += depth * firewall[depth].size
  end
  firewall.transform_values! do |scanner|
    tentative_pos = scanner.pos + scanner.dir
    scanner.dir = -scanner.dir if tentative_pos < 0 || tentative_pos >= scanner.size
    scanner.pos += scanner.dir
    scanner
  end
end

puts severity
