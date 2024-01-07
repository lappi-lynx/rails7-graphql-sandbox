class Account < ApplicationRecord
  belongs_to :client
  has_many :assets

  enum :holdings_type, [:investing, :pension]

  validates :name, :holdings_type, :currency, presence: true

  def equity
    # TODO use Money gem for currency conversion and operations
    total_in_cents = assets.sum('assets.quantity * assets.latest_price')

    (total_in_cents / 100.0).round(2)
  end
end
