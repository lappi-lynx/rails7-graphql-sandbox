# frozen_string_literal: true

module Types
  class ClientType < Types::BaseObject
    field :id, ID, null: false
    field :full_name, String, null: false
    field :email, String, null: false
    field :ssn, String, null: false
    field :locale, String
    field :total_equity, Float, null: true, description: "Total equity of client's accounts in requested currency" do
      argument :currency, String, required: false, description: "Currency in which to calculate the total equity"
    end
    field :accounts, [Types::AccountType], null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def full_name
      "#{object.first_name} #{object.last_name}"
    end

    def total_equity(currency: nil)
      currency.present? ? object.total_equity(currency:) : object.total_equity
    end
  end
end
