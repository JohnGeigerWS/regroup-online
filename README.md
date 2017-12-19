# Drive Online

A Rails app that serves up the Live/VOD Streaming experience for Drive Conference.

## Stack

- Ruby 2.3.3
- Rail 5
- Postgres
- Redis
- Sidekiq
- Mailgun
- Foundation 6 + Admin Theme

## Setup

### DNS

- setup DNS in Hover for `online.driveconference.com`
- setup an SSL cert

### Heroku

**Addons**

- Heroku Postgres: Hobby Basic, ensure backups are setup
- Heroku Redis: Premium0
    - Set the `maxmemory` policy: `heroku redis:maxmemory --policy allkeys-lru -a my-super-cool-app`
- Papertrail: Free
- New Relic: Free

**Buildpacks**

- heroku/heroku-buildpack-redis: required for a secure connection to Redis
- heroku/ruby

### Eventbrite

- Setup Webhook for the event
    - Account Settings -> Webhooks -> Create Webhook
    - Payload URL: `https://online.driveconference.com/webhooks/eventbrite/order_placed`
    - Event: the event
    - Actions: `order.placed`
