require 'sendgrid-ruby'

SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])