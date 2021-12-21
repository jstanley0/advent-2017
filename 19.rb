require_relative '../2021/skim'

maze = Skim.read(rec: false)
x, y = maze.find_coords('|')
dx, dy = 0, 1
path = ""
steps = 0

loop do
  c = maze[x, y]
  case c
  when 'A'..'Z'
    path << c
  when '+'
    maze.nabes(x, y, diag: false) do |val, a, b|
      next if a == x - dx && b == y - dy

      if val != ' '
        dx = a - x
        dy = b - y
        break
      end
    end
  when ' '
    break
  end
  x += dx
  y += dy
  steps += 1
end

puts path
puts steps
