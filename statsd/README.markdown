(Modeled after the [go-learning-products:statsd](https://github.com/lethain/go-learning-projects/tree/master/statsd) project.)


## Goals

1.  Write a UDP server in Go that runs on port 8125.
3.  Implement support for the the [Counter](https://github.com/b/statsd_spec) type (one of three types of metrics supported by Statsd).
4.  Buffer metrics and flush them to stdout or stderr every 10 seconds.
5.  (Bonus) Use the [flag](https://golang.org/pkg/flag/) module to allow changing port.
6.  (Bonus) Implement Gauge and Timer types.
7.  (Bonus) Synchronize flushing to avoid threading race conditions using either the [sync](https://golang.org/pkg/sync/) module
    or [channels](https://gobyexample.com/channels).

## References

1. [Statsd Protocol Specification ](https://github.com/b/statsd_spec)



## Validation

You can verify your server using the [ruby-statsd](https://github.com/reinh/statsd) client.

First, install it:

    gem install statsd-ruby

Then run a script along these lines:

    require 'statsd'
    s = Statsd.new 'localhost', 8125
    s.increment 'my_count'
    s.timing 'my_timer', 500
    s.gauge 'my_gauge', 2000

Then you should see all of those get processed within your server.

