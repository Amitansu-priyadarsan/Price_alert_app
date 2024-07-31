class PriceCheckJob
  include Sidekiq::Worker

  def perform
    loop do
      Alert.where(status: 'created').each do |alert|
        PriceCheckService.new(alert).call
      end
      sleep 5  # Sleep for 5 seconds
    end
  end
end
