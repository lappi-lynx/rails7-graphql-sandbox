# frozen_string_literal: true

module Types
  class AccountType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :holdings_type, Integer
    field :currency, String, null: false
    field :client_id, Integer, null: false
    field :assets, [Types::AssetType], null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
