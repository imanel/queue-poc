require 'redis'

# Connect to Redis @ localhost
redis = Redis.new
list_name = '01_list'

10.times do |i|
  redis.rpush(list_name, i)
end
