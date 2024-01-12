require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:ssn) }
  end

  describe '#full_name' do
    let(:client) { build(:client, first_name: 'John', last_name: 'Doe') }

    it 'returns the correct full name' do
      expect(client.full_name).to eq('John Doe')
    end
  end

  describe '#total_equity' do
    let(:client)    { create(:client) }
    let!(:account1) { create(:account, client: client, currency: 'USD') }
    let!(:account2) { create(:account, client: client, currency: 'EUR') }

    before do
      allow(CurrencyConverter).to receive(:convert).and_call_original
    end

    context 'when currency is supported' do
      it 'returns the total equity in the specified currency' do
        total_equity = client.total_equity(currency: 'USD')
        expected_equity = CurrencyConverter.convert(account1.equity, account1.currency, 'USD') +
                          CurrencyConverter.convert(account2.equity, account2.currency, 'USD')

        expect(total_equity).to be > 0
        expect(total_equity).to eq(expected_equity.round(2))
      end
    end

    context 'when currency is supported' do
      it 'returns the total equity in the specified currency' do
        total_equity = client.total_equity(currency: 'EUR')
        expected_equity = CurrencyConverter.convert(account1.equity, account1.currency, 'EUR') +
                          CurrencyConverter.convert(account2.equity, account2.currency, 'EUR')

        expect(total_equity).to be > 0
        expect(total_equity).to eq(expected_equity.round(2))
      end
    end

    context 'when currency is not supported' do
      it 'returns nil' do
        expect(client.total_equity(currency: 'XXX')).to be_nil
      end
    end

    context 'when using base currency' do
      it 'returns the correct total equity' do
        total_equity_in_base_currency = client.total_equity
        expected_equity = CurrencyConverter.convert(account1.equity, account1.currency, 'CHF') +
                          CurrencyConverter.convert(account2.equity, account2.currency, 'CHF')

        expect(total_equity_in_base_currency).to be > 0
        expect(total_equity_in_base_currency).to eq(expected_equity.round(2))
      end
    end
  end
end
