require 'socket'


class SimpleRedis
  def initialize
    @keys = {}
  end

  def process(cmd, *params)
    puts "processing #{cmd}: #{params}"
    case cmd.downcase
    when "get"
      if @keys.key? params[0]
        val = @keys[params[0]]
        "$#{val.to_s.length}\r\n#{val}\r\n"
      else
        "$-1\r\n"
      end
    when "set"
      @keys[params[0]] = params[1]
      "+OK\r\n"
    else
      "+OK\r\n"
    end
  end

  def handle(sock)
    n, = /^\*(\d+)\r\n$/.match(sock.readline).captures
    cmds = []
    (0...n.to_i).each do |_|
      _size = sock.readline
      cmds << sock.readline.chomp
    end
    sock.puts self.process(*cmds)
    sock.close
  end
end


server = TCPServer.new(6379)
sr = SimpleRedis.new

loop do
  begin
    socket = server.accept_nonblock
    sr.handle(socket)
  rescue IO::WaitReadable, Errno::EINTR
    IO.select([server])
    retry
  end
end
