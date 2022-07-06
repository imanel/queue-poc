require "redis"

# Connect to Redis @ localhost
redis = Redis.new
list_name = "01_list"
benchmark_size = 10_000

redis.del(list_name)

# Benchmark write spead

before_time = Time.now

benchmark_size.times do |i|
  redis.rpush(list_name, i)
end

after_time = Time.now
time_taken = after_time - before_time
rps = benchmark_size / time_taken

puts "Write: time taken: #{time_taken}s, #{rps.round} RPS."

# Benchmark read spead

before_time = Time.now

while redis.lpop(list_name) do
  # Do nothing
end

after_time = Time.now
time_taken = after_time - before_time
rps = benchmark_size / time_taken

puts "Read: time taken: #{time_taken}s, #{rps.round} RPS."
