require 'redis'
require 'time'

# Connect to Redis @ localhost
redis = Redis.new
list_name = '02_list'
processing_list_name = '02_processing'
timeout = 5

loop do
  # Fetch all items on the processing list (obviously naive for production code)
  processing_list = redis.lrange(processing_list_name, 0, -1)
  processing_list.each do |item|

    cache_key = processing_list_name + ':' + item
    timestamp = redis.get(cache_key) # Fetch cache key, it's expiration timestamp
    if timestamp
      # If the timestamp of timeout is already in the past
      if Time.parse(timestamp) < Time.now
        # Redis is unable to atomically move provided item
        puts "Restoring: #{item}"
        redis.del(cache_key) # Delete cache key first to avoid accidental re-creation
        redis.rpush(list_name, item) # Add back to the main queue
        # Remove from processing, but only 1 instance. If by accident it's added again (i.e. immediately picked up
        # by worker) the new instance will still be there, preventing loss of data
        redis.lrem(processing_list_name, 1, item)
      end
    else
      # If the cache doesn't exist let's create it.
      puts "Creating cache for: #{item}"
      redis.set(cache_key, Time.now + timeout) # Create the cache for item containing expiration timestamp
      redis.expire(cache_key, timeout * 2) # Expire in double the timeout seconds for easier cleanup
    end

  end

  sleep 1 # Rest to avoid overloading Redis
end
