class AddApprovedToTakenPromos < ActiveRecord::Migration
  def change
    add_column :taken_promos, :approved_at, :timestamp
    add_column :taken_promos, :approved_by, :integer
  end
end
