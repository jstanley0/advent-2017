require 'byebug'

class TuringMachine
  attr_accessor :begin_state, :checksum_steps, :rules
  Rule = Struct.new(:in_state, :read_value, :write_value, :move_dir, :new_state)

  def initialize
    read
  end

  def extract(re)
    line = ARGF.gets
    return nil unless line
    match = line.match(re)
    #puts "#{line.chomp} => #{match.inspect}"
    match && match[1]
  end

  def read
    self.begin_state = extract(/Begin in state ([A-Z]+)\./)
    self.checksum_steps = extract(/Perform a diagnostic checksum after (\d+) steps\./).to_i
    ARGF.gets

    self.rules = {}
    while (rule = read_rule)
      rules[rule[0].in_state] = rule
    end
  end

  def read_rule
    in_state = extract(/In state ([A-Z]+):/)
    return nil unless in_state

    segs = [read_rule_segment(in_state), read_rule_segment(in_state)]
    ARGF.gets

    segs
  end

  def read_rule_segment(in_state)
    rule = Rule.new
    rule.in_state = in_state
    rule.read_value = extract(/If the current value is (0|1):/).to_i
    rule.write_value = extract(/Write the value (0|1)\./).to_i
    rule.move_dir = extract(/Move one slot to the (left|right)\./)
    rule.move_dir = (rule.move_dir == 'left') ? -1 : 1
    rule.new_state = extract(/Continue with state ([A-Z]+)\./)
    rule
  end

  def run
    state = begin_state
    tape = [0] * 100
    pos = 50
    checksum_steps.times do
      val = tape[pos]
      rule = rules[state][val]
      tape[pos] = rule.write_value
      pos += rule.move_dir
      state = rule.new_state

      if pos < 0
        tape = ([0] * 100) + tape
        pos += 100
      elsif pos >= tape.size
        tape.concat [0] * 100
      end
    end
    tape.count(1)
  end
end

machine = TuringMachine.new

puts machine.run
