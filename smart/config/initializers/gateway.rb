
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
    tv = Tv.find_or_initialize_by(name: update.name)
    tv.name = update.name
    tv.channel = update.channel
    tv.status = update.status
    tv.volume = update.volume
    tv.save if tv.changed.any?

  when :light_update
    tv = Light.find_or_initialize_by(name: update.name)
    tv.name = update.name
    tv.channel = update.channel
    tv.status = update.status
    tv.volume = update.volume
    tv.save if tv.changed.any?
  end
end


@server = TCPServer.new(4445)
puts("Waiting for gateway...")
GATEWAY = @server.accept

ApplicationRecord.transaction do
  Ac.delete_all
  Tv.delete_all
  Light.delete_all
end

@listener = Thread.new do
  begin
    loop do
      size = GATEWAY.gets.to_i
      message = GATEWAY.read(size)
      req = Request.decode(message)
      handle(req)
    end
  ensure
    @server.close
  end
end
