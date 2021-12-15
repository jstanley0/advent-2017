class Spirl
  DIRS = [[1, 0], [0, -1], [-1, 0], [0, 1]]

  def initialize
    @x = 0
    @y = 0
    @dir = 0
    @dist_tot = 1
    @dist_rem = 1
    @dist_clk = false
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
    check_extents

    @dist_rem -= 1
    if @dist_rem == 0
      @dir = (@dir + 1) % 4
      @dist_clk = !@dist_clk
      if !@dist_clk
        @dist_tot += 1
      end
      @dist_rem = @dist_tot
    end
  end

  def dist
    @x.abs + @y.abs
  end
end

s = Spirl.new
n = gets.to_i
(n - 1).times { s.step }
puts s.dist
