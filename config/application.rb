require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DriveOnline
  class Application < Rails::Application
    # TODO: Why is the services dir not autoloading?
    config.time_zone = 'Eastern Time (US & Canada)'
    config.autoload_paths << "#{Rails.root}/app/services"
    config.eager_load_paths << "#{Rails.root}/app/services"
    config.active_job.queue_adapter = :sidekiq
    config.cache_store = :redis_store, "#{ENV['REDIS_URL']}/0/cache", { expires_in: 24.hours }
    config.paths.add 'app/presenters', :eager_load => true

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = 'Eastern Time (US & Canada)'

    config.action_mailer.smtp_settings = {
      :address              => ENV['EMAIL_SERVER'],
      :port                 => ENV['EMAIL_PORT'],
      :user_name            => ENV['EMAIL_USERNAME'],
      :password             => ENV['EMAIL_PASSWORD'],
      :domain               => ENV['EMAIL_DOMAIN'],
      :authentication       => :plain,
      :enable_starttls_auto => true,
      :openssl_verify_mode  => 'none'
    }
    # :smtp for above :mailgun for below
    config.action_mailer.delivery_method = :mailgun
    config.action_mailer.mailgun_settings = {
        api_key: ENV['MAILGUN_API_KEY'],
        domain: ENV['MAILGUN_DOMAIN'],
        public_key: ENV['MAILGUN_PUBLIC_KEY'],
        smtp_login: ENV['MAILGUN_SMTP_LOGIN'],
        smtp_password: ENV['MAILGUN_SMTP_PASSWORD'],
        smtp_port: ENV['MAILGUN_SMTP_PORT'],
        smtp_server: ENV['MAILGUN_SMTP_SERVER']
    }
  end
end
