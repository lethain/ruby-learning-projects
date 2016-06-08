require 'redis'

redis = Redis.new(:port => 6379)
g1 = redis.get("mykey")
puts "g1: \"#{g1}\", expected \"\""
redis.set("mykey", 10)
g2 = redis.get("mykey")
puts "g2: \"#{g2}\", expected \"10\""
redis.set("mykey", 20)
g3 = redis.get("mykey")
puts "g3: \"#{g3}\", expected \"20\""
