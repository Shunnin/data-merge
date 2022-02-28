require "typhoeus/cache/redis"

redis = Redis.new(GlobalSetting.redis_config(Settings.REDIS_DB))
Typhoeus::Config.cache = Typhoeus::Cache::Redis.new(redis)
Typhoeus::Config.user_agent = 'Data Merge'