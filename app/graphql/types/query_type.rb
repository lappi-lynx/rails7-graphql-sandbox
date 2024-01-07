# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :clients, [Types::ClientSimpleType], null: false, description: "Return a list of clients"
    field :client, Types::ClientType, null: true, description: "Return a signle client" do
      argument :id, ID, required: true, description: "ID of the client."
    end

    def clients
      Client.includes(accounts: :assets).all
    end
    def client(id:)
      Client.includes(accounts: :assets).find_by(id:)
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end
  end
end
