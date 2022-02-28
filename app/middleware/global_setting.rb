module GlobalSetting
  class << self

    def redis_store_config
      redis_config(Settings.REDIS_DB)
    end

    def redis_config(db)
      uri = URI.parse(redis_url)

      {
        host:     uri.host,
        port:     uri.port,
        password: uri.password,
        db:       db
      }
    end

    def redis_url
      Settings.REDIS_URL
    end
  end

end
