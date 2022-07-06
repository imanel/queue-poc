## Running

```
bundle exec ruby producer.rb
bundle exec ruby consumer.rb
```

You can also run consumer in multiple terminals to see that it distributes load nicely.

## Issues

Press CTRL+C while execution of consumer, start it again. This will skip the number, which means that "at least once"
promise is not fulfilled.
