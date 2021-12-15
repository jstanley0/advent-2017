orig = ARGF.gets.chomp
data = orig.chars

def read_garbage(data)
  c = data.shift
  raise "expected <" unless c == '<'

  loop do
    case data.shift
    when '!'
      data.shift
    when '>'
      return 0
    end
  end
end

def read_group_or_garbage(data, depth)
  case data.first
  when '{'
    read_group(data, depth)
  when '<'
    read_garbage(data)
  else
    0
  end
end

def read_group(data, depth = 1)
  c = data.shift
  raise "expected {" unless c == '{'

  score = depth
  score += read_group_or_garbage(data, depth + 1)

  loop do
    c = data.shift
    case c
    when ','
      score += read_group_or_garbage(data, depth + 1)
    when '}'
      break
    else
      raise "expected , or } group delimiter"
    end
  end

  score
end

puts read_group(data)
puts data.join
