class AddIndexToPromos < ActiveRecord::Migration
  def change
    add_index :promos, :category_id
  end
end
