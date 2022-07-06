require 'redis'

# Connect to Redis @ localhost
redis = Redis.new
list_name = '02_list'
processing_list_name = '02_processing'

loop do
  item = redis.blmove(list_name, processing_list_name, 'LEFT', 'RIGHT') # https://redis.io/commands/blmove/

  sleep 1
  puts "Processed: #{item}"

  redis.lrem(processing_list_name, 1, item) # https://redis.io/commands/lrem/
end
