class Account < ApplicationRecord
  belongs_to :client
  has_many :assets

  enum :type, [:investing, :pension]

  validates :name, :type, :currency, presence: true
end
