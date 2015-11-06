class AddRejectToTakenPromo < ActiveRecord::Migration
  def change
    add_column :taken_promos, :rejected_at, :timestamp
    add_column :taken_promos, :rejected_by, :integer
  end
end
