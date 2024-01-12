RSpec.describe 'Update Client Locale Mutation', type: :request do
  describe 'updating client locale' do
    let!(:client) { create(:client) }

    it 'updates the locale of a client' do
      post graphql_path, params: { query: update_locale_mutation(client.id, 'de') }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['data']['updateClientLocale']['locale']).to eq('de')
    end
  end

  def update_locale_mutation(client_id, new_locale)
    <<~GQL
      mutation {
        updateClientLocale(input: { clientId: #{client_id}, locale: "#{new_locale}" }) {
          id
          fullName
          locale
        }
      }
    GQL
  end
end
