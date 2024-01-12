RSpec.describe Types::ClientSimpleType do
  subject { described_class }

  it { is_expected.to have_field(:id).of_type('ID!') }
  it { is_expected.to have_field(:full_name).of_type('String!') }
  it { is_expected.to have_field(:email).of_type('String!') }
  it { is_expected.to have_field(:ssn).of_type('String!') }
  it { is_expected.to have_field(:locale).of_type('String') }
  it { is_expected.to have_field(:created_at).of_type('ISO8601DateTime!') }
  it { is_expected.to have_field(:updated_at).of_type('ISO8601DateTime!') }
end
