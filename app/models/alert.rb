class Alert < ApplicationRecord
  belongs_to :user
  validates :cryptocurrency, :target_price, :status, presence: true
end
