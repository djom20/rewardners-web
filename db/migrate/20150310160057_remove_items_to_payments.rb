class RemoveItemsToPayments < ActiveRecord::Migration
  def change
    remove_column :payments, :transaction_carrier, :string
    remove_column :payments, :retention, :float
    remove_column :payments, :active_purchased, :boolean
    remove_column :payments, :trasaction_state, :string
    remove_column :payments, :status, :boolean
  end
end
