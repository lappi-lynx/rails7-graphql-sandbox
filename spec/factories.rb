FactoryBot.define do
  factory(:client) do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    ssn { Faker::IDNumber.valid }

    trait :with_account do
      after(:create) do |client|
        create(:account, :investing, client: client)
        create(:account, :pension, client: client)
      end
    end
  end

  factory :account do
    client
    currency { 'USD' }
    holdings_type { 0 }
    name { 'Test Account' }

    trait :investing do
      name { "#{client.first_name} #{client.last_name} investing account" }
      currency { 'USD' }
      holdings_type { 0 }
    end

    trait :pension do
      name { "#{client.first_name} #{client.last_name} pension account" }
      currency { 'CHF' }
      holdings_type { 1 }
    end

    after(:create) do |account|
      5.times do
        create(:asset, account: account)
      end
    end
  end

  factory :asset do
    account
    ticker { Faker::Finance.ticker }
    quantity { rand(1..100) }
    latest_price { rand(1..10000) }
    market_iso_code { account.currency == 'USD' ? 'XNYS' : 'SIX' }
  end
end
