source 'https://rubygems.org'
ruby "2.3.3"

gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'cancancan', '~> 1.15'
gem 'cocoon', '~> 1.2', '>= 1.2.9'
gem 'coffee-rails', '~> 4.2'
gem 'curb'
gem 'devise', '~> 4.2'
gem 'devise_invitable', '~> 1.7.0'
gem 'figaro' , '~>1.1'
gem 'foundation-rails', '~> 6.3'
gem 'foundation-icons-sass-rails', '~> 3.0'
gem 'friendly_id', '~> 5.2'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'mailgun-rails'
gem 'omniauth', '~> 1.3'
gem 'pg', '~> 0.19.0'
gem 'puma', '~> 3.0'
gem 'redis', '~> 3.0'
gem 'redis-rails', '~> 5.0', '>= 5.0.1'
gem 'sidekiq', '~> 4.2', '>= 4.2.7'
gem 'sinatra', git: 'https://github.com/sinatra/sinatra', require: nil
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'faraday', '~> 0.10.1'

group :test do
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3.5', '>= 3.5.2'
  gem 'factory_girl_rails', '~> 4.8'
  gem 'timecop', '~> 0.8.1'
  gem 'capybara', '~> 2.11'
  gem 'poltergeist', '~> 1.12'
end

group :development do
  gem 'awesome_print', '~> 1.7'
  gem 'guard-rails', '~> 0.8.0', require: false
  gem 'guard-rspec', '~> 4.7', '>= 4.7.3', require: false
  gem 'meta_request', '~> 0.4.0'
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'guard-sidekiq', '~> 0.1.0'
end

group :production do
  gem 'rails_12factor', '~> 0.0.3'
  gem 'rack-timeout', '~> 0.4.2'
  gem 'newrelic_rpm', '~> 3.17', '>= 3.17.2.327'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
