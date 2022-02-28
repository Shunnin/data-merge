if !Rails.env.test?
  REDIS = Redis.new(GlobalSetting.redis_config(Settings.REDIS_DB))
end
