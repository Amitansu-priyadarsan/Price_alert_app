require 'sidekiq'
require 'sidekiq-cron'

Sidekiq::Cron::Job.create(
  name: 'Price Check - every 5 seconds',
  cron: '* * * * * *',  # Runs every second
  class: 'PriceCheckJob'
)
