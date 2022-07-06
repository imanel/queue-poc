require 'redis'

# Connect to Redis @ localhost
redis = Redis.new
list_name = '01_list'

loop do
  item = redis.blpop(list_name) # Returns [list_name, item], blocks while waiting for next item

  sleep 1
  puts "Processed: #{item[1]}"
end
