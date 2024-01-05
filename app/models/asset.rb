class Asset < ApplicationRecord
  belongs_to :account

  validates :ticker, :quantity, :latest_price, :market_iso_code, presence: true
end
