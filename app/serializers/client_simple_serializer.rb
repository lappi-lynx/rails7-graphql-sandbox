class ClientSimpleSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :email, :ssn, :locale
end
