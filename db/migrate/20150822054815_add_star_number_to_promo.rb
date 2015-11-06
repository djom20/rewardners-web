class AddStarNumberToPromo < ActiveRecord::Migration
  def change
    add_column :promos, :star_number, :integer, default: 1
  end
end
