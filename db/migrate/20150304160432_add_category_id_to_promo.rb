class AddCategoryIdToPromo < ActiveRecord::Migration
  def change
    add_column :promos, :category_id, :integer
  end
end
