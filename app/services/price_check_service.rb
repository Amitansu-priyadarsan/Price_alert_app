class PriceCheckService
  def initialize(alert)
    @alert = alert
  end

  def call
    current_price = fetch_current_price(@alert.cryptocurrency)
    if @alert.target_price <= current_price
      @alert.update(status: 'triggered')
      AlertMailer.with(alert: @alert).price_alert.deliver_now
    end
  end

  private

  def fetch_current_price(cryptocurrency)
    # Implement Binance WebSocket or CoinGecko API call
    url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=USD&ids=#{cryptocurrency}"
    response = HTTParty.get(url)
    price = response[0]['current_price']
    price
  end
end
