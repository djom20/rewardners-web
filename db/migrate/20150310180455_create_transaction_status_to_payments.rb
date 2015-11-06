class CreateTransactionStatusToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :transaction_status, :string
  end
end
