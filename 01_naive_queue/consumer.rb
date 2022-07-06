require "redis"

# Connect to Redis @ localhost
redis = Redis.new
list_name = "01_list"

while item = redis.lpop(list_name) do
  sleep 1
  puts item
end
