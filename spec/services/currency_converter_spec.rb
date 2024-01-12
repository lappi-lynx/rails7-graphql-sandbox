require 'rails_helper'

RSpec.describe CurrencyConverter, type: :model do
  describe '.convert' do
    context 'when converting from USD to CHF' do
      it 'converts correctly' do
        amount = 100
        expected_amount = (amount / CurrencyConverter::RATES['USD']).floor(2)
        expect(CurrencyConverter.convert(100, 'USD', 'CHF')).to eq(expected_amount)
      end
    end

    context 'when converting from EUR to CHF' do
      it 'converts correctly' do
        amount = 100
        expected_amount = (amount / CurrencyConverter::RATES['EUR']).floor(2)
        expect(CurrencyConverter.convert(100, 'EUR', 'CHF')).to eq(expected_amount)
      end
    end

    context 'when converting from CHF to USD' do
      it 'converts correctly' do
        amount = 100
        expected_amount = amount * CurrencyConverter::RATES['USD']
        expect(CurrencyConverter.convert(amount, 'CHF', 'USD')).to eq(expected_amount)
      end
    end

    context 'when converting the same currency' do
      it 'returns the same amount' do
        amount = 100
        expect(CurrencyConverter.convert(amount, 'CHF', 'CHF')).to eq(amount)
      end
    end
  end
end
