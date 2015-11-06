class AddAvailableToTakenPromo < ActiveRecord::Migration
  def change
    add_column :taken_promos, :available, :boolean
  end
end
