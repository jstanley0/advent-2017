Coord = Struct.new(:x, :y, :z) do
  def +(other)
    Coord.new(x + other.x, y + other.y, z + other.z)
  end

  def -(other)
    Coord.new(x - other.x, y - other.y, z - other.z)
  end

  def dist(other)
    dx = x - other.x
    dy = y - other.y
    dz = z - other.z
    Math.sqrt(dx * dx + dy * dy + dz * dz)
  end

  def manhattan_distance(other)
    (x - other.x).abs + (y - other.y).abs + (z - other.z).abs
  end

  def rotate_x
    Coord.new(x, -z, y)
  end

  def rotate_y
    Coord.new(z, y, -x)
  end

  def rotate_z
    Coord.new(-y, x, z)
  end
end

Particle = Struct.new(:p, :v, :a)

particles = ARGF.lines.map do |line|
  Particle.new(*line.scan(/-?\d+,-?\d+,-?\d+/).map { |c| Coord.new(*c.split(',').map(&:to_i)) })
end

orange = Coord.new(0, 0, 0)
10000.times do |t|
  particles.each_with_index do |particle, i|
    particle.v += particle.a
    particle.p += particle.v
  end
  particles.delete_if { |p| particles.count { |q| q.p == p.p } > 1 }
  mp = particles.each_with_index.map { |p, i| [orange.manhattan_distance(p.p), i] }.min
  puts "#{t}: remaining: #{particles.size} closest: #{mp.last}"
end
