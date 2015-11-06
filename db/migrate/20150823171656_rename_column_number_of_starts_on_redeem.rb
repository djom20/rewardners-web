class RenameColumnNumberOfStartsOnRedeem < ActiveRecord::Migration
  def change
    rename_column :redeems, :number_of_starts, :number_of_stars
  end
end
