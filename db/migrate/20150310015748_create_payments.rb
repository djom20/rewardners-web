class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :user, index: true
      t.string :transaction_id
      t.timestamp :purchased_at
      t.text :notification_params
      t.string :transaction_carrier
      t.timestamp :expiration_date
      t.float :amount
      t.float :retention
      t.string :item_type
      t.string :status
      t.boolean :active_purchased

      t.timestamps
    end
  end
end
