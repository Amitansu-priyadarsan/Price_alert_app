require 'sendgrid-ruby'
include SendGrid

class AlertMailer < ApplicationMailer
  def price_alert_triggered
    @alert = params[:alert]
    @current_price = params[:current_price]
    mail = Mail.new
    mail.from = Email.new(email: ENV['SENDGRID_SENDER_EMAIL'])
    mail.subject = 'Price Alert Triggered'
    personalization = Personalization.new
    personalization.add_to(Email.new(email: @alert.user.email))
    mail.add_personalization(personalization)
    mail.add_content(Content.new(type: 'text/plain', value: "The price of #{@alert.cryptocurrency} has reached your target price of #{@alert.target_price}. Current price: #{@current_price}."))

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    Rails.logger.info("Email sent with status code #{response.status_code}")
  end

  def price_alert_fallen
    @alert = params[:alert]
    @current_price = params[:current_price]
    mail = Mail.new
    mail.from = Email.new(email: ENV['SENDGRID_SENDER_EMAIL'])
    mail.subject = 'Price Alert Status Update'
    personalization = Personalization.new
    personalization.add_to(Email.new(email: @alert.user.email))
    mail.add_personalization(personalization)
    mail.add_content(Content.new(type: 'text/plain', value: "The price of #{@alert.cryptocurrency} has fallen below your target price of #{@alert.target_price}. Current price: #{@current_price}."))

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    Rails.logger.info("Email sent with status code #{response.status_code}")
  end
end
