require 'rails_helper'

RSpec.describe ClientsController, type: :controller do
  describe 'GET #index' do
    before do
      create_list(:client, 3)
      get :index
    end

    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'returns a JSON array of clients' do
      json_response = JSON.parse(response.body)
      expect(json_response).to be_a(Array)
      expect(json_response.size).to eq(5)
    end

    it 'returns clients with correct data' do
      json_response = JSON.parse(response.body)
      expect(json_response.first).to include('id', 'full_name', 'email', 'ssn', 'locale')
    end
  end

  describe 'GET #show' do
    let(:client) { create(:client, :with_account) }

    before do
      get :show, params: { id: client.id }
    end

    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'returns a client as JSON' do
      json_response = JSON.parse(response.body)
      expect(json_response).to be_a(Hash)
    end

    it 'returns the client with the correct attributes' do
      json_response = JSON.parse(response.body)
      expect(json_response).to include('id', 'first_name', 'last_name', 'email', 'ssn', 'locale', 'total_equity', 'accounts', 'created_at', 'updated_at')
    end

    it 'includes accounts in the response' do
      json_response = JSON.parse(response.body)
      expect(json_response['accounts']).to be_a(Array)
      expect(json_response['accounts']).not_to be_empty
    end

    it 'includes correct attributes for accounts' do
      json_response = JSON.parse(response.body)
      account = json_response['accounts'].first
      expect(account).to include('id', 'name', 'type', 'currency', 'equity', 'assets')
    end

    it 'includes assets for each account' do
      json_response = JSON.parse(response.body)
      account = json_response['accounts'].first
      expect(account['assets']).to be_a(Array)
      expect(account['assets']).not_to be_empty
    end

    it 'includes correct attributes for assets' do
      json_response = JSON.parse(response.body)
      asset = json_response['accounts'].first['assets'].first
      expect(asset).to include('id', 'ticker', 'quantity', 'latest_price', 'market_iso_code')
    end

    context 'with currency parameter' do
      it 'calculates total equity in the specified currency' do
        get :show, params: { id: client.id, currency: 'EUR' }
        json_response = JSON.parse(response.body)
      end
    end
  end
end
