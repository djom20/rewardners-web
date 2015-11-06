class AddRejectedReasonToTakenPromo < ActiveRecord::Migration
  def change
    add_column :taken_promos, :rejected_reason, :text
  end
end
