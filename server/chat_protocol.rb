# frozen_string_literal: true

class ChatClient
  TOKEN = {
    INIT: 'START CHAT',
    M_END: 'END',
    M_REQUEST: 'MESSAGE',
    M_BEG: 'BROADCAST',
    U_REQUEST: 'LIST USERS',
    RES_OK: 'OK',
    RES_BAD: 'BAD',
    EXIT: 'EXIT'
  }.freeze

  attr_reader :username, :valid, :sock

  def initialize(sock)
    @sock = sock
    @username = ''
    @valid = false
  end

  def init!
    if gets.eql?(TOKEN[:INIT])
      cmd_ok!
    else
      cmd_bad!
    end
  end

  def get_username!
    @username = gets
    cmd_ok!
  end

  def chat!
    @valid = true

    command = gets
    case command
    when TOKEN[:M_REQUEST]
      msg = read_lines
      broadcast(msg, @username)
      cmd_ok!

    when TOKEN[:U_REQUEST]
      ACTIVE_CLIENTS.values.each.with_index do |client, idx|
        next unless client.valid

        puts("#{idx}: #{client.username} #{'(you)' if client.sock.fileno.eql?(@sock.fileno)}")
      end
      cmd_ok!

    when TOKEN[:EXIT]
      broadcast('saiu da sala', 'GOODBYE: ' + @username)
      cmd_ok!
      throw QUIT_SIG

    else
      cmd_bad!
    end
  end

  def broadcast(string, name)
    ACTIVE_CLIENTS.each do |fileno, client|
      next if @sock.fileno.eql?(fileno)
      next unless client.valid

      client.send_lines(string, name)
    end
  end
  
  def read_lines
    msg = String.new; line = ''
    while line != TOKEN[:M_END]
      msg << line
      line = gets
    end
    msg
  end

  def send_lines(string, sender)
    puts(TOKEN[:M_BEG])
    puts(sender)
    string.each_line do |line|
      puts(line)
    end
    puts(TOKEN[:M_END])
  end

  def puts(s)
    @sock.puts(s)
  rescue
    throw QUIT_SIG
  end
  private :puts

  def gets
    input = @sock.gets
    throw QUIT_SIG unless input

    input.chop
  end
  private :gets

  def cmd_bad!
    puts(TOKEN[:RES_BAD])
    throw QUIT_SIG
  end
  private :cmd_bad!

  def cmd_ok!
    puts(TOKEN[:RES_OK])
  end
  private :cmd_ok!
end
