## Running

```
bundle exec ruby producer.rb
bundle exec ruby consumer.rb # Separate tab
bundle exec ruby monitor_timeout.rb # Separate tab
```

You can also run consumer in multiple terminals to see that it distributes load nicely, but monitor should run only once.

Press CTRL+C while execution of consumer, start it again. This will skip the number, however monitor will pick it up
after several seconds and add it at the back of the queue.

## Issues

- Lack of support for multiple queues and priorities
- No backoff for rate limit
