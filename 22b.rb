require_relative '../2021/skim'

world = Skim.read
x = world.width / 2
y = world.height / 2
a = 0

DX = [0, 1, 0, -1]
DY = [-1, 0, 1, 0]

infections = 0

10000000.times do
  case world[x, y]
  when '.'
    a = (a - 1) % 4
    world[x, y] = 'W'
  when 'W'
    world[x, y] = '#'
    infections += 1
  when '#'
    a = (a + 1) % 4
    world[x, y] = 'F'
  when 'F'
    a = (a + 2) % 4
    world[x, y] = '.'
  end
  x += DX[a]
  y += DY[a]
  unless world.in_bounds?(x, y)
    pad = [world.width / 2, 5].max
    puts "padding world from #{world.width} to #{world.width + 2 * pad}"
    world = world.pad(pad, '.')
    x += pad
    y += pad
  end
  #world.print
end

#world.print
puts infections
