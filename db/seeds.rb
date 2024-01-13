# create 5 clients with 2 accounts each with assets each

5.times do
  Client.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    ssn: Faker::IDNumber.valid,
    locale: 'de-DE'
  )
end

Client.all.each do |client|
  Account.create!(
    name: "#{client.first_name} #{client.last_name} investing",
    holdings_type: 0,
    currency: "USD",
    client: client
  )

  Account.create!(
    name: "#{client.first_name} #{client.last_name} pension",
    holdings_type: 1,
    currency: "CHF",
    client: client
  )
end

Account.all.each do |account|
  rand(5..15).times do
    ticker = Faker::Finance.ticker

    next if account.assets.where(ticker: ticker).present?
    Asset.create!(
      ticker: ticker,
      quantity: rand(100),
      latest_price: rand(10000),
      market_iso_code: (account.currency == "USD" ? "XNYS" : "SIX"),
      account: account
    )
  end
end
