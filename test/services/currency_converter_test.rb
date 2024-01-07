require "test_helper"

class CurrencyConverterTest < ActiveSupport::TestCase
  test "converts correctly from USD to CHF" do
    amount = 100
    expected_amount = (amount / CurrencyConverter::RATES['USD']).floor(2)
    assert_equal expected_amount, CurrencyConverter.convert(100, 'USD', 'CHF')
  end

  test "converts correctly from EUR to CHF" do
    amount = 100
    expected_amount = (amount / CurrencyConverter::RATES['EUR']).floor(2)
    assert_equal expected_amount, CurrencyConverter.convert(100, 'EUR', 'CHF')
  end

  test "converts correctly from CHF to USD" do
    amount = 100
    expected_amount = amount * CurrencyConverter::RATES['USD']
    assert_equal expected_amount, CurrencyConverter.convert(amount_in_chf, 'CHF', 'USD')
  end

  test "returns same amount for same currency conversion" do
    amount = 100
    assert_equal amount, CurrencyConverter.convert(amount, 'CHF', 'CHF')
  end
end
