Node = Struct.new(:name, :weight, :children, :mark)
nodes = {}
ARGF.lines.each do |line|
  _, name, weight, children = line.match(/([a-z]+) \((\d+)\)(?: -> (.+))?/).to_a
  weight = weight.to_i
  children = children.to_s.split(", ")
  nodes[name] = Node.new(name, weight, children)
end

def mark_node(nodes, c)
  nodes[c].children.each do |c|
    mark_node(nodes, c)
  end
  nodes[c].mark = true
end

nodes.each do |name, node|
  node.children.each { |c| mark_node(nodes, c) }
end

root = nodes.values.detect { |n| !n.mark }.name
puts root

def weight(nodes, c)
  node = nodes[c]
  w = node.weight
  cw = node.children.map { |cn| weight(nodes, cn) }
  w + cw.sum
end

def direct_weight(nodes, c)
  nodes[c].children.each do |cn|
    puts "#{cn}: #{nodes[cn].weight} #{weight(nodes, cn)}"
  end
end

direct_weight(nodes, root)
direct_weight(nodes, 'zklwp')
direct_weight(nodes, 'lahahn')
direct_weight(nodes, 'utnrb')
