class AddLocationToPlace < ActiveRecord::Migration
  def change
    add_column :places, :country, :string
    add_column :places, :city, :string
    add_column :places, :state, :string
  end
end
