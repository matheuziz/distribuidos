@s = TCPServer.new(4445)
puts("Waiting for gateway...")
GATEWAY = @s.accept

Ac.delete_all
Tv.delete_all
Light.delete_all

def handle(request)
  return unless request

  update = request.send(request.update)
  case request.update
  when :ac_update
    ac = Ac.find_or_initialize_by(name: update.name)
    ac.name = update.name
    ac.mode = update.mode.to_s
    ac.status = update.status
    ac.temperature = update.temperature
    ac.save if ac.changed.any?
  when :tv_update
  when :light_update
  end
end

Thread.new do
  begin
    loop do
      size = GATEWAY.gets.to_i
      message = GATEWAY.read(size)
      req = Request.decode(message)
      handle(req)
    end
  ensure
    @s.close
  end
end
