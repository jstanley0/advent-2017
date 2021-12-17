require 'set'

pipes = ARGF.lines.inject({}) do |h, line|
  src, dst = line.split(" <-> ")
  src = src.to_i
  dst = dst.split(",").map(&:to_i)
  h[src] = dst
  h
end

unmatched = Set.new
pipes.keys.each { |n| unmatched.add n }

def connect_group(group, pipes, n)
  pipes[n].each do |conn|
    unless group.include?(conn)
      group.add conn
      connect_group(group, pipes, conn)
    end
  end
end

groups = []
until unmatched.empty?
  n = unmatched.first
  group = Set.new
  connect_group(group, pipes, n)
  unmatched.subtract group
  groups << group
end

puts groups.size

