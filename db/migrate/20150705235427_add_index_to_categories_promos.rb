class AddIndexToCategoriesPromos < ActiveRecord::Migration
  def change
    add_index :categories_promos, [:category_id, :promo_id]
  end
end
