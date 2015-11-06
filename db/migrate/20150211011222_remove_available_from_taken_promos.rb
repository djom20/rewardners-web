class RemoveAvailableFromTakenPromos < ActiveRecord::Migration
  def change
    remove_column :taken_promos, :available, :integer
  end
end
