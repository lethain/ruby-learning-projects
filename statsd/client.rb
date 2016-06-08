require 'statsd'

s = Statsd.new '127.0.0.1', 8125
s.increment 'my_count'
s.timing 'my_timer', 500
s.gauge 'my_gauge', 2000
