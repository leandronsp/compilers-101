require 'json'

def evaluate(term, scope = {})
  case term
  in { kind: 'Print', value: value }; puts evaluate(value, scope)
  in { kind: 'Int', value: value }; value.to_i
  in { kind: 'Str', value: value }; value.to_s
  in { kind: 'Bool', value: value }; value
  in { kind: 'Binary', op: op, lhs: lhs, rhs: rhs }
    operation = { 'Add' => '+', 'Sub' => '-', 'Eq' => '==', 'Lt' => '<' }[op]

    left = evaluate(lhs, scope)
    right = evaluate(rhs, scope)

    case [left, right]
    in [Integer, Integer]; left.send(operation.to_sym, right) 
    else "#{left}#{right}"
    end
  in { kind: 'Var', text: text }; scope[text]
  in { kind: 'Let', name: { text: text }, value: value, next: next_ }
    scope[text] = evaluate(value, scope)
    evaluate(next_, scope)
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
