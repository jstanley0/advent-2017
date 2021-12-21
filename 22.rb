require_relative '../2021/skim'

world = Skim.read
x = world.width / 2
y = world.height / 2
a = 0

DX = [0, 1, 0, -1]
DY = [-1, 0, 1, 0]

infections = 0

10000.times do
  infected = (world[x, y] == '#')
  a += (infected ? 1 : -1)
  a = a % 4
  world[x, y] = infected ? '.' : '#'
  infections += 1 unless infected
  x += DX[a]
  y += DY[a]
  unless world.in_bounds?(x, y)
    puts "padding world from #{world.width} to #{world.width + 10}"
    pad = [world.width / 2, 5].max
    world = world.pad(pad, '.')
    x += pad
    y += pad
  end
end

#world.print
puts infections
