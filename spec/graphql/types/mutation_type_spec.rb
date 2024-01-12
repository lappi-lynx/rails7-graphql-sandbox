RSpec.describe Types::MutationType do
  subject { described_class }

  describe 'updateClientLocale' do
    let(:mutation_field) { subject.fields['updateClientLocale'] }

    it 'has correct input type' do
      expect(mutation_field).to have_an_input_field(:input).of_type('UpdateClientLocaleInput!')
    end
  end
end
