
firewall = ARGF.lines.inject({}) do |h, line|
  depth, range = line.split(":").map(&:to_i)
  h[depth] = 2 * range - 2 # convert to period
  h
end

def caught?(firewall, delay)
  firewall.any? { |depth, period| (depth + delay) % period == 0 }
end

delay = 0
while caught?(firewall, delay)
  delay += 1
end

puts delay
