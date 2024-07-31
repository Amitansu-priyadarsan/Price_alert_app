require 'httparty'

class PriceCheckService
  def initialize(alert)
    @alert = alert
  end

  def call
    current_price = fetch_current_price(@alert.cryptocurrency)
    if @alert.target_price <= current_price
      unless @alert.status == 'triggered'
        @alert.update(status: 'triggered')
        AlertMailer.with(alert: @alert, current_price: current_price).price_alert_triggered.deliver_now
      end
    else
      if @alert.status == 'triggered'
        @alert.update(status: 'price_fallen')
        AlertMailer.with(alert: @alert, current_price: current_price).price_alert_fallen.deliver_now
      end
    end
  end

  private

  def fetch_current_price(cryptocurrency)
    url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=USD&ids=#{cryptocurrency}"
    response = HTTParty.get(url)
    price = response.parsed_response[0]['current_price']
    price
  end
end
