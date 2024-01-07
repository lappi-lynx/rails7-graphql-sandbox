class ClientSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :ssn, :locale, :total_equity, :accounts, :created_at, :updated_at
  has_many :accounts, serializer: AccountSerializer

  def total_equity
    object.total_equity(currency: instance_options[:currency])
  end
end
