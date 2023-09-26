require 'json'

def evaluate(term)
  case term
  in { kind: 'Str', value: value }; value.to_s
  in { kind: 'Print', value: next_term }; puts evaluate(next_term)
  else raise "Unknown term: #{term}"
  end
end

######################

input = ""

while line = STDIN.gets
  input += line
end

parsed = JSON.parse(input, symbolize_names: true)

evaluate(parsed[:expression])
