class CreateAssets < ActiveRecord::Migration[7.1]
  def change
    create_table :assets do |t|
      t.string :ticker, null: false
      t.integer :quantity, null: false
      t.integer :latest_price, null: false
      t.string :market_iso_code, null: false
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
