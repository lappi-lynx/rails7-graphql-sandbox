class Client < ApplicationRecord
  has_many :accounts

  validates :first_name, :last_name, :email, :ssn, presence: true

  def total_equity(currency: BASE_CURRENCY)
    total_in_cents = accounts.includes(:assets).reduce(0) do |sum, account|
      sum += CurrencyConverter.convert(account.equity, account.currency, BASE_CURRENCY)
    end

    (total_in_cents / 100).round(2)
  end

  private

  BASE_CURRENCY = 'CHF'.freeze
end
