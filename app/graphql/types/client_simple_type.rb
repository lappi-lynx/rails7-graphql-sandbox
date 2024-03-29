# frozen_string_literal: true

module Types
  class ClientSimpleType < Types::BaseObject
    field :id, ID, null: false
    field :full_name, String, null: false
    field :email, String, null: false
    field :ssn, String, null: false
    field :locale, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def full_name
      "#{object.first_name} #{object.last_name}"
    end
  end
end
