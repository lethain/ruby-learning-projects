require 'socket'

class StatsdServer
  def initialize(host, port, buffer=1024, timeout=5)
    @sock = UDPSocket.new
    @sock.bind(host, port)
    @buffer = buffer
    @timeout = timeout
    @last_flush = Time.now.to_i
    self.initialize_state
  end

  def initialize_state
    @timers, @gauges, @counters = {}, {}, {}
  end

  def handle(msg)
    key, val, kind = /([a-zA-Z_-]+):([0-9.]+)\|([a-z]+)/.match(msg).captures
    case kind
    when 'c'
      @counters[key] ||= 0
      @counters[key] +=  val.to_i
    when 'g'
      @gauges[key] = val.to_i
    when 'ms'
      (@timers[key] ||= []) << val.to_i
    else
      puts "unknown kind: #{kind} from msg: #{msg}"
    end
  end

  def flush
    puts "timers: #{@timers}"
    puts "gauges: #{@gauges}"
    puts "counters: #{@counters}"
    self.initialize_state    
    @last_flush = Time.now.to_i
  end

  def run
    loop do
      begin
        now = Time.now.to_i
        if @last_flush < now - @timeout
          self.flush()
        end        
        msg, _ = @sock.recvfrom_nonblock(@buffer)       
        self.handle(msg)
      rescue IO::WaitReadable
        IO.select([@sock], nil, nil, @timeout)
        retry
      end
    end
  end
end

ss = StatsdServer.new("127.0.0.1", 8125)
ss.run()
