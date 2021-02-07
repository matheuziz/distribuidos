require 'socket'
require_relative 'chat_protocol'

CONFIG = {
  PORT: ARGV[0],
  LOGGER: ARGV[1] || STDOUT
}.freeze

QUIT_SIG = :Q

CONFIG[:LOGGER].puts('Starting server at: ' + CONFIG[:PORT].to_s)

SERVER = TCPServer.new(CONFIG[:PORT])
ACTIVE_CLIENTS = Hash.new

def client_lifetime(client)
  client.init!
  client.get_username!
  loop do
    client.chat!
  end
end

def handle(client_sock)
  client = ACTIVE_CLIENTS.store(
    client_sock.fileno, 
    ChatClient.new(client_sock)
  )
  CONFIG[:LOGGER].puts("active_clients:" + ACTIVE_CLIENTS.size.to_s)
catch (QUIT_SIG) { client_lifetime(client) }
ensure
  ACTIVE_CLIENTS.delete(client_sock.fileno)
  client_sock.close
  CONFIG[:LOGGER].puts("active_clients:" + ACTIVE_CLIENTS.size.to_s)
end

# Main server loop
loop do
  client_sock = SERVER.accept
  Thread.new { handle(client_sock) }
end
