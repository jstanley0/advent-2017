require 'set'

pipes = ARGF.lines.inject({}) do |h, line|
  src, dst = line.split(" <-> ")
  src = src.to_i
  dst = dst.split(",").map(&:to_i)
  h[src] = dst
  h
end

def connect_group(group, pipes, n)
  pipes[n].each do |conn|
    unless group.include?(conn)
      group.add conn
      connect_group(group, pipes, conn)
    end
  end
end

group = Set.new
connect_group(group, pipes, 0)

puts group.inspect
puts group.size
