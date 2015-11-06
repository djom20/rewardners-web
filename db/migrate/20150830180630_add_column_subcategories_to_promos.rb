class AddColumnSubcategoriesToPromos < ActiveRecord::Migration
  def change
    add_column :promos, :subcategory1_id, :integer
    add_column :promos, :subcategory2_id, :integer
  end
end
