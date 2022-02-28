schedule_file = 'app/tasks/schedule.yml'

Sidekiq.configure_server do |config|
  config.redis = GlobalSetting.redis_config(Settings.SIDEKIQ_DB)

  Rails.logger = Sidekiq::Logging.logger

  config.death_handlers << ->(job, _ex) do
    SidekiqUniqueJobs::Digests.del(digest: job['unique_digest']) if job['unique_digest']
  end
end

Sidekiq.configure_client do |config|
  config.redis = GlobalSetting.redis_config(Settings.SIDEKIQ_DB)
end

if File.exist?(schedule_file) && Sidekiq.server?
  Rails.application.config.after_initialize do
    Sidekiq::Cron::Job.load_from_hash! YAML.load_file(schedule_file)
  end
end
