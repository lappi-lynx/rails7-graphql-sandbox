# frozen_string_literal: true

module Types
  class AccountType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :type, String, null: false
    field :currency, String, null: false
    field :client_id, Integer, null: false
    field :assets, [Types::AssetType], null: true
    field :equity, Float, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def type
      object.holdings_type == 0 ? "investing" : "pension"
    end
  end
end
