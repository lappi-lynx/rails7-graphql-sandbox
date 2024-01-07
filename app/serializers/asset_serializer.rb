class AssetSerializer < ActiveModel::Serializer
  attributes :id, :ticker, :quantity, :latest_price, :market_iso_code
end
