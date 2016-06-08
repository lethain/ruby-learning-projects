(This project is modeled after the [Redis project in go-learning-projects](https://github.com/lethain/go-learning-projects/tree/master/redis).)

## Prerequisites

1. Read the [Redis Protocol Specification](http://redis.io/topics/protocol).
2. Take a look at [Ruby's Socket module](http://ruby-doc.org/stdlib-1.9.3/libdoc/socket/rdoc/Socket.html).

## Goals

1. Write a TCP server in Go that runs on port `6379`.
2. It should support `get`, `set` and `del` operations.
3. It should synchronize data access for safe concurrent read/writes (look into the [sync](https://golang.org/pkg/sync/) package).
4. Bonus: periodically synchronize data to disc (take a look at the [gob](https://golang.org/pkg/encoding/gob/) package).
5. Bonus: [support more commands](http://redis.io/commands), especially consider how to
    support the blocking pop commands (`BRPOP` and `BLPOP`), which are often used to
        implement simple queuing systems on top of Redis.

## Validation

First, install the [redis-rb](https://github.com/redis/redis-rb) client:

    gem install redis

Then you can run a simple script along these lines to verify function:

    require "redis"

    redis = Redis.new(:port => 6379)
    g1 = redis.get("mykey")
    puts "g1: #{g1}, expected nil"
    redis.set("mykey", 10)
    g2 = redis.get("mykey")
    puts "g2: #{g2}, expected 10"