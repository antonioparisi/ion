# Redis debug
class Redis::Client
  def call(*args)
    puts "REDIS:" + args.inspect.join(' ')
    process(args) { read }
  end
end

