module Mutations
  class UpdateClientLocale < BaseMutation
    argument :client_id, ID, required: true
    argument :locale, String, required: true

    type Types::ClientSimpleType

    def resolve(client_id:, locale:)
      client = Client.find_by(id: client_id)

      client.update(locale: locale) if client.present?

      client
    end
  end
end
