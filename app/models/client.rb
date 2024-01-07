class Client < ApplicationRecord
  has_many :accounts

  validates :first_name, :last_name, :email, :ssn, presence: true

  def total_equity(currency: BASE_CURRENCY)
    accounts.includes(:assets).reduce(0) do |sum, account|
      sum += CurrencyConverter.convert(account.equity, account.currency, BASE_CURRENCY)
    end
  end

  private

  BASE_CURRENCY = 'CHF'.freeze
end
