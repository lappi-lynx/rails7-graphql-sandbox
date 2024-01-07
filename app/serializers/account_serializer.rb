class AccountSerializer < ActiveModel::Serializer
  attributes :id, :name, :type, :currency, :equity, :assets
  has_many :assets, serializer: AssetSerializer

  def type
    object.holdings_type == 0 ? 'investing' : 'pension'
  end
end
