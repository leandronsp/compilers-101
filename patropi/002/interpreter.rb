require 'json'

def evaluate(term, scope = {})
  case term
  in { kind: 'Print', value: value }; puts evaluate(value, scope)
  in { kind: 'Int', value: value }; value.to_i
  in { kind: 'Str', value: value }; value.to_s
  in { kind: 'Binary', op: op, lhs: lhs, rhs: rhs }
    left = evaluate(lhs, scope)
    right = evaluate(rhs, scope)

    case [op, left, right]
    in ['Add', Integer, Integer]; left + right # interpretacao (execucao)
    else "#{left}#{right}"
    end
  else 
    puts "Invalid term #{term}"
  end
end

######################

input = ""

while line = STDIN.gets
  input += line
end

parsed = JSON.parse(input, symbolize_names: true)

evaluate(parsed[:expression])
