Inst = Struct.new(:opcode, :x, :y)

program = ARGF.lines.map do |line|
  Inst.new(*line.chomp.split).tap do |inst|
    inst.x = inst.x.to_i unless inst.x =~ /[a-z]+/
    inst.y = inst.y.to_i unless inst.y.nil? || inst.y =~ /[a-z]+/
  end
end

class Computer
  def initialize(program, program_id)
    @program = program
    @ip = 0
    @regs = {'p' => program_id}
    @rx_queue = []
    @tx_queue = nil
    @sent = 0
    @need_input = false
    @terminated = false
    @program_id = program_id
  end

  def link(other)
    @tx_queue = other.instance_variable_get(:@rx_queue)
    other.instance_variable_set(:@tx_queue, @rx_queue)
  end

  def rvalue(reg_or_value)
    return reg_or_value if reg_or_value.is_a?(Integer)
    @regs[reg_or_value] ||= 0
  end

  def run
    while @ip >= 0 && @ip < @program.size
      inst = @program[@ip]
      #puts "#{@ip}. #{inst.opcode} #{inst.x} #{inst.y} #{@regs.inspect}"
      case inst.opcode
      when 'snd'
        @tx_queue << rvalue(inst.x)
        puts "#{@program_id} sent #{@tx_queue.last}"
        @sent += 1
      when 'set'
        @regs[inst.x] = rvalue(inst.y)
      when 'add'
        @regs[inst.x] ||= 0
        @regs[inst.x] += rvalue(inst.y)
      when 'mul'
        @regs[inst.x] ||= 0
        @regs[inst.x] *= rvalue(inst.y)
      when 'mod'
        @regs[inst.x] ||= 0
        @regs[inst.x] %= rvalue(inst.y)
      when 'rcv'
        if @rx_queue.empty?
          puts "#{@program_id} waiting for input"
          @need_input = true
          return
        else
          puts "#{@program_id} received #{@rx_queue.first}"
          @regs[inst.x] = @rx_queue.shift
          @need_input = false
        end
      when 'jgz'
        @ip += rvalue(inst.y) - 1 if rvalue(inst.x) > 0
      end
      @ip += 1
    end
    @terminated = true
  end

  def stats
    "#{@program_id}: sent=#{@sent}"
  end

  def need_input?
    @need_input && @rx_queue.empty?
  end

  def terminated?
    @terminated
  end
end

comp0 = Computer.new(program, 0)
comp1 = Computer.new(program, 1)
comp0.link(comp1)

loop do
  comp0.run
  comp1.run
  break if (comp0.terminated? && comp1.terminated?) || (comp0.need_input? && comp1.need_input?)
end

puts comp0.stats
puts comp1.stats
