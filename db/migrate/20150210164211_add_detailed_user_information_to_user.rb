class AddDetailedUserInformationToUser < ActiveRecord::Migration
  def change
    add_column :users, :address, :string
    add_column :users, :city, :string
    add_column :users, :manager, :string
    add_column :users, :phone, :string
  end
end
