class AddTransactionDataToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :currency, :string
    add_column :payments, :transaction_create_time, :timestamp
    add_column :payments, :transaction_update_time, :timestamp
    add_column :payments, :trasaction_state, :string
    add_column :payments, :payment_method, :string
    add_column :payments, :shipping_address, :string
  end
end
