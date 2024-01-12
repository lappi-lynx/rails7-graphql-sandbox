require 'rails_helper'

RSpec.describe 'Client Query', type: :request do
  describe 'fetching single client' do
    let!(:client)   { create(:client, :with_account) }
    let(:account_1) { client.accounts.first }
    let(:asset_1)   { account_1.assets.first }

    it 'returns a client with total equity, accounts and assets' do
      post graphql_path, params: { query: single_client_query(client.id) }
      expect(response).to have_http_status(:success)
      client_response = JSON.parse(response.body)['data']['client']

      expect(client_response['id']).to eq(client.id.to_s)
      expect(client_response['email']).to eq(client.email)
      expect(client_response['locale']).to eq(client.locale)
      expect(client_response['ssn']).to eq(client.ssn)
      expect(client_response['fullName']).to eq(client.full_name)
      expect(client_response['totalEquity']).to eq(client.total_equity(currency: 'USD'))
      expect(client_response['totalEquity']).not_to eq(client.total_equity(currency: 'CHF'))
      expect(client_response['accounts'].length).to eq(client.accounts.count)
      expect(client_response['accounts']).to be_a(Array)
      expect(client_response['accounts']).not_to be_empty

      first_account_data = client_response['accounts'][0]

      expect(first_account_data['id']).to eq(account_1.id.to_s)
      expect(first_account_data['name']).to eq(account_1.name)
      expect(first_account_data['type']).to eq(account_1.holdings_type)
      expect(first_account_data['clientId']).to eq(account_1.client_id)
      expect(first_account_data['currency']).to eq(account_1.currency)
      expect(first_account_data['equity']).to eq(account_1.equity)
      expect(first_account_data['assets'].length).to eq(account_1.assets.count)
      expect(first_account_data['assets']).to be_a(Array)
      expect(first_account_data['assets']).not_to be_empty

      first_asset_data = first_account_data['assets'][0]

      expect(first_asset_data['ticker']).to eq(asset_1.ticker)
      expect(first_asset_data['quantity']).to eq(asset_1.quantity)
      expect(first_asset_data['latestPrice']).to eq(asset_1.latest_price)
      expect(first_asset_data['marketIsoCode']).to eq(asset_1.market_iso_code)
    end
  end

  def single_client_query(id)
    <<~GQL
      query {
        client(id: #{id}) {
          id
          fullName
          email
          ssn
          locale
          totalEquity(currency: "USD")
          accounts {
            id
            name
            type
            clientId
            currency
            equity
            assets {
              ticker
              quantity
              latestPrice
              marketIsoCode
            }
          }
        }
      }
    GQL
  end
end
