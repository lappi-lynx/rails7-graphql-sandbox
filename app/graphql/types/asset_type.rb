# frozen_string_literal: true

module Types
  class AssetType < Types::BaseObject
    field :id, ID, null: false
    field :ticker, String, null: false
    field :quantity, Integer, null: false
    field :latest_price, Integer, null: false
    field :market_iso_code, String, null: false
    field :account_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
