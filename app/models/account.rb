class Account < ApplicationRecord
  belongs_to :client
  has_many :assets

  enum :holdings_type, [:investing, :pension]

  validates :name, :holdings_type, :currency, presence: true
end
