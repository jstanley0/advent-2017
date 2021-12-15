orig = ARGF.gets.chomp
data = orig.chars

def read_garbage(data)
  c = data.shift
  raise "expected <" unless c == '<'
  count = 0
  loop do
    case data.shift
    when '!'
      data.shift
    when '>'
      return count
    else
      count += 1
    end
  end
end

def read_group_or_garbage(data)
  case data.first
  when '{'
    read_group(data)
  when '<'
    read_garbage(data)
  else
    0
  end
end

def read_group(data)
  c = data.shift
  raise "expected {" unless c == '{'

  score = read_group_or_garbage(data)

  loop do
    c = data.shift
    case c
    when ','
      score += read_group_or_garbage(data)
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
