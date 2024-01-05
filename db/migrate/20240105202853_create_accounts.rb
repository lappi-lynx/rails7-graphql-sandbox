class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.integer :type, default: 0
      t.string :currency, null: false
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
