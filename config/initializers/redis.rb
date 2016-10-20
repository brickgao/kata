if File.exist?(".In_Container")
  $redis = Redis.new(:host => "redis.local", :prot => 6379)
else
  $redis = Redis.new(:host => "127.0.0.1", :port => 6379)
end
