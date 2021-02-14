require 'socket'
require 'json'

GATEWAY = TCPSocket.new(ARGV[0], ARGV[1])  

state = {
  type: 'AC',
  temperature: 23,
  name: 'Consul' + (rand * 100).to_i.to_s,
  status: true,
  mode: 'COOL'
}

def change(state)
  state[:temperature] = (rand * 100).to_i % 30
end

Thread.new do
  loop do
    message = GATEWAY.gets
    STDOUT.puts("RECIEVED UPDATE: #{message}")
    json = JSON.parse(message)
    state = json.transform_keys(&:to_sym).merge(type: 'AC')
  end
end

i = 0
loop do
  i += 1
  change(state) if i % 3 == 0
  GATEWAY.puts(state.to_json)
  STDOUT.puts("SENT UPDATE: #{state.to_json}")
  sleep(5)
end
