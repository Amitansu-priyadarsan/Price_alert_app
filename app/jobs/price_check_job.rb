class PriceCheckJob
  include Sidekiq::Worker

  def perform(alert_id)
    alert = Alert.find(alert_id)
    PriceCheckService.new(alert).call
  end
end
