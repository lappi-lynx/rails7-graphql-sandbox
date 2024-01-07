class Account < ApplicationRecord
  belongs_to :client
  has_many :assets

  enum :holdings_type, [:investing, :pension]

  validates :name, :holdings_type, :currency, presence: true

  def equity
    # TODO use Money gem for currency conversion and operations
    assets.reduce(0) do |sum, asset|
      sum += BigDecimal(asset.latest_price.to_s) * asset.quantity
    end
  end
end
