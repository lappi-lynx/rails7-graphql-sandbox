### Graphql + REST API server sandbox
Usage:
`bundle exec rails db:create db:migrate db:seed`
`bundle exec rails s -p 3001`

#### GraphiQL - http://localhost:3001/graphiql:
```
// Clients list fetch:
{
  clients {
    id
    fullName
    email
    ssn
    locale
  }
}

// Client full info:
{
  client(id: 1) {
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
      assets{
        ticker
        quantity
        latestPrice
        marketIsoCode
      }
    }
  }
}

// Mutation example:
mutation {
  updateClientLocale(input: { clientId: 1, locale: "de" }) {
    id
    fullName
    locale
  }
}
```
#### Datamodel:
```
create_table "accounts", force: :cascade do |t|
    t.string "name", null: false
    t.integer "holdings_type", default: 0
    t.string "currency", null: false
    t.bigint "client_id", null: false
    t.index ["client_id"], name: "index_accounts_on_client_id"
  end

  create_table "assets", force: :cascade do |t|
    t.string "ticker", null: false
    t.integer "quantity", null: false
    t.integer "latest_price", null: false
    t.string "market_iso_code", null: false
    t.bigint "account_id", null: false
    t.index ["account_id"], name: "index_assets_on_account_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "ssn", null: false
    t.string "locale"
  end
```

