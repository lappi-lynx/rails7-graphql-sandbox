require 'rails_helper'

RSpec.describe 'Clients Query', type: :request do
  describe 'fetching clients' do
    let!(:clients) { create_list(:client, 3) }

    it 'returns a list of clients' do
      post graphql_path, params: { query: query }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['data']['clients'].length).to eq(3)
      expect(json['data']['clients'][0]).to include(
        'id',
        'fullName',
        'email',
        'ssn',
        'locale'
      )
    end
  end

  def query
    <<~GQL
      query {
        clients {
          id
          fullName
          email
          ssn
          locale
        }
      }
    GQL
  end
end

