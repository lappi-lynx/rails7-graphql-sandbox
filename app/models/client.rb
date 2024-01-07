class Client < ApplicationRecord
  has_many :accounts

  validates :first_name, :last_name, :email, :ssn, presence: true

  def total_equity(currency: BASE_CURRENCY)
    return nil if ::CurrencyConverter.unsupported_currency?(currency)

    accounts.includes(:assets).reduce(0) do |sum, account|
      sum += ::CurrencyConverter.convert(account.equity, account.currency, currency)
    end
  end

  private

  BASE_CURRENCY = 'CHF'.freeze
end
