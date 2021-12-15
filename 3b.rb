require_relative '../2021/skim'

class Spirl
  DIRS = [[1, 0], [0, -1], [-1, 0], [0, 1]]

  def initialize
    @x = 0
    @y = 0
    @dir = 0
    @dist_tot = 1
    @dist_rem = 1
    @dist_clk = false

    @data = Skim.new(100, 100, 0)
    @data[50,50] = 1
  end

  def step
    # right 1
    # up 1
    # left 2
    # down 2
    # right 3
    # left 4
    # ...

    @x += DIRS[@dir][0]
    @y += DIRS[@dir][1]

    @dist_rem -= 1
    if @dist_rem == 0
      @dir = (@dir + 1) % 4
      @dist_clk = !@dist_clk
      if !@dist_clk
        @dist_tot += 1
      end
      @dist_rem = @dist_tot
    end

    @data[50 + @x, 50 + @y] = @data.nv(50 + @x, 50 + @y).sum
  end

  def dist
    @x.abs + @y.abs
  end
end

s = Spirl.new
n = gets.to_i
loop do
  v = s.step
  if v > n
    puts v
    break
  end
end
