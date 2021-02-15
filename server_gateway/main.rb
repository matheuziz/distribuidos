require 'socket'
require 'json'
require_relative 'protobuf'

CONFIG = {
  PORT: ARGV[0],
  LOGGER: ARGV[1] || STDOUT,
  INTERFACE_PORT: 4445,
  INTERFACE_HOST: 'localhost'
}.freeze

QUIT_SIG = :Q

CONFIG[:LOGGER].puts('Starting server at: ' + CONFIG[:PORT].to_s)

SERVER = TCPServer.new(CONFIG[:PORT])
WEBSERVER = TCPSocket.new(CONFIG[:INTERFACE_HOST], CONFIG[:INTERFACE_PORT])
ACTIVE_CLIENTS = Hash.new
DEVICES = Hash.new

def debug(msg)
  CONFIG[:LOGGER].puts("DEBUG -- " + msg.to_s)
end

@reciever = Thread.new do
  loop do
    size = WEBSERVER.gets.to_i
    message = WEBSERVER.read(size)
    debug("RECIEVED MESSAGE OF SIZE: #{size}")
    debug(message.inspect)
    req = Request.decode(message)
    update = req.send(req.update)
    json = update.to_h.to_json
    debug("RELAYING TO: #{update.name}: #{json}")
    DEVICES[update.name].puts(json)
  end
end

def hash_to_protobuf(hash)
  type = hash['type']
  hash.delete('type')
  keys = hash.transform_keys(&:to_sym)
  case type
  when 'AC'
    {ac_update: AcUpdate.new(keys)}
  when 'TV'
    {tv_update: TvUpdate.new(keys)}
  when 'LIGHT'
    {light_update: LightUpdate.new(keys)}
  end
end

def client_lifetime(client_sock)
  loop do
    message = client_sock.gets
    next unless message

    object = JSON.parse(message)
    DEVICES.store(object['name'], client_sock)
    req = Request.new(hash_to_protobuf(object))
    message = Request.encode(req)
    WEBSERVER.puts(message.size)
    WEBSERVER.write(message)
  end
end

def handle(client_sock)
  ACTIVE_CLIENTS.store(client_sock.fileno, true)
  CONFIG[:LOGGER].puts("active_clients:" + ACTIVE_CLIENTS.size.to_s)
catch (QUIT_SIG) { client_lifetime(client_sock) }
ensure
  ACTIVE_CLIENTS.delete(client_sock.fileno)
  client_sock.close
  CONFIG[:LOGGER].puts("active_clients:" + ACTIVE_CLIENTS.size.to_s)
end

# Main server loop
begin
  loop do
    client_sock = SERVER.accept
    Thread.new { handle(client_sock) }
  end
ensure
  WEBSERVER.close
  SERVER.close
end
