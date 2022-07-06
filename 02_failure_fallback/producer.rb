require 'json'
require 'redis'
require 'securerandom'

# Connect to Redis @ localhost
redis = Redis.new
list_name = '02_list'

10.times do
  uuid = SecureRandom.uuid
  item = { "id": uuid }
  serialized_item = item.to_json
  redis.rpush(list_name, serialized_item)
end
