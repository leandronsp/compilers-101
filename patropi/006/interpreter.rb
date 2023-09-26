require 'json'

def evaluate(term, scope = {}, location)
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
  in { kind: 'Function', parameters: parameters, value: value }
    ->(*args) do 
      params = parameters.map { |param| param[:text] }
      arguments = params.zip(args).to_h

      evaluate(value, scope.merge(arguments))
    end
  in { kind: 'Call', callee: callee, arguments: arguments }
    args = arguments.map { |arg| evaluate(arg, scope) }
    function = evaluate(callee, scope)
    function.(*args)
  in { kind: 'If', condition: condition, then: then_, otherwise: otherwise }
    if evaluate(condition, scope)
      evaluate(then_, scope)
    else 
      evaluate(otherwise, scope)
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

term = parsed[:expression]
location = parsed[:location]

@terms = [term]
@executors = []
scope = {}

#evaluate(parsed[:expression])

loop do 
  term = @terms.pop
  break if term.nil?
  continuation, result, scope, location = evaluate(term, scope, location)

  begin 
    case [continuation, result]
    in [:raw, result]
      executor = @executors.pop
      continuation, result, scope, location = executor&.call(result)

      next if continuation == :noop

      while executor = @executors.pop
        continuation, result, scope, location = executor&.call(result)
        break if continuation == :noop
      end
    in [:noop, nil]; next
    else raise Error.new(location, "Unknown continuation: #{continuation} with #{result}")
    end
  rescue => e
    raise Error.new(location, "Unexpected error while evaluating continuation: #{e.message}")
  end
end
