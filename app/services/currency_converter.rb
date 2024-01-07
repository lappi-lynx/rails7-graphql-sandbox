class CurrencyConverter
  RATES = {
    'CHF' => 1.0,
    'USD' => 1.18,
    'EUR' => 1.07
  }.freeze

  # TODO use Money gem for currency conversion and operations
  def self.convert(amount, from, to)
    return amount if (from == to)

    base_amount = amount / RATES[from]

    (base_amount * RATES[to]).floor(2)
  end
end
