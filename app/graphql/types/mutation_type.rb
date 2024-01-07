# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # Usage example:
    # mutation {
    #   updateClientLocale(input: { clientId: 1, locale: "de" }) {
    #     id
    #     fullName
    #     locale
    #   }
    # }
    field :update_client_locale, mutation: Mutations::UpdateClientLocale
  end
end
