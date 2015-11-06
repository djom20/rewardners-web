class RemoveClearDataToPayments < ActiveRecord::Migration
  def change
    remove_column :payments, :notification_params, :text
    remove_column :payments, :purchased_at, :timestamp
  end
end
