require 'socket'
require 'json'

GATEWAY = TCPSocket.new(ARGV[1], ARGV[2])  

DEFAULTS = {
  AC: {
    type: 'AC',
    temperature: 23,
    name: 'Consul ' + (rand * 100).to_i.to_s,
    status: true,
    mode: 'COOL'
  },
  TV: {
    type: 'TV',
    channel: 19,
    volume: 50,
    name: 'LGTV ' + (rand * 100).to_i.to_s,
    status: true
  },
  LIGHT: {
    type: 'LIGHT',
    brightness: 69,
    color: 'RED',
    name: 'Led Strip ' + (rand * 100).to_i.to_s
  }
}

state = case ARGV[0]
        when /ac/i then DEFAULTS[:AC]
        when /tv/i then DEFAULTS[:TV]
        when /light/i then DEFAULTS[:LIGHT]
        end

def randomness(state)
  return unless ((rand * 100).to_i % 3 == 0)

  attrs = state.dup
  attrs.each do |k, _|
    next unless %i[brightness channel temperature].include?(k)

    state[k] = (rand * 100).to_i % 100
  end
end

@reciever = Thread.new do
  loop do
    message = GATEWAY.gets
    STDOUT.puts("RECIEVED UPDATE: #{message}")
    json = JSON.parse(message)
    state = json.transform_keys(&:to_sym).merge(type: state['type'])
  end
end

begin
  loop do
    randomness(state)
    GATEWAY.puts(state.to_json)
    STDOUT.puts("SENT UPDATE: #{state.to_json}")
    sleep(5)
  end
ensure
  GATEWAY.close
end
