adapters = ARGF.lines.map do |line|
  line.split('/').map(&:to_i).sort
end

def build_bridges(adapters, from)
  bridges = []
  candidates = adapters.select { |a| a.include?(from) }
  candidates.each do |adapter|
    other = (adapter - [from])[0] || adapter[0]
    sub_bridges = build_bridges(adapters - [adapter], other)
    sub_bridges.each do |sub_bridge|
      bridges << [adapter] + sub_bridge
    end
    bridges << [adapter]
  end
  bridges
end

bridges = build_bridges(adapters, 0)
puts bridges.map { |bridge| bridge.flatten.sum }.max
puts bridges.max_by { |bridge| [bridge.size, bridge.flatten.sum] }.flatten.sum
