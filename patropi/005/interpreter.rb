require 'json'

def evaluate(term, scope)
  case term
  in { kind: 'Str', value: value }; [:raw, value.to_s, scope]
  in { kind: 'Print', value: next_term }
    @executors.push(-> (result) { 
      puts result
      [:raw, result, scope]
    })

    @terms.push(next_term)
    [:noop, nil, scope]
  else raise "Unknown term: #{term}"
  end
end

######################

input = ""

while line = STDIN.gets
  input += line
end

parsed = JSON.parse(input, symbolize_names: true)

term = parsed[:expression]
#evaluate(term)

@terms = [term]
@executors = []
scope = {}


loop do 
  term = @terms.pop
  break if term.nil?
  continuation, result, scope = evaluate(term, scope)

  case [continuation, result]
  in [:raw, result]
    executor = @executors.pop # -> lambda, closure, proc
    continuation, result, scope = executor&.call(result)

    next if continuation == :noop

    while executor = @executors.pop
      continuation, result, scope = executor&.call(result)
      break if continuation == :noop
    end
  in [:noop, nil]; next
  else raise "Unexpected continuation #{[continuation, result]}"
  end
end
