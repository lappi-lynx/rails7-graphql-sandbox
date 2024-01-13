# create 5 clients with 2 accounts each with 3 assets each

5.times do
  Client.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    ssn: Faker::IDNumber.valid
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
  rand(5..20).times do
    Asset.create!(
      ticker: Faker::Finance.ticker,
      quantity: rand(100),
      latest_price: rand(10000),
      market_iso_code: (account.currency == "USD" ? "XNYS" : "SIX"),
      account: account
    )
  end
end
