web: bin/start-stunnel bundle exec puma -C config/puma.rb
worker: bin/start-stunnel bundle exec sidekiq -c 3 -q default -q mailers
