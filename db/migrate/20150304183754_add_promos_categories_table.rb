class AddPromosCategoriesTable < ActiveRecord::Migration
  def change
    create_table :categories_promos, id: false do |t|
      t.integer :category_id
      t.integer :promo_id
    end
  end
end
