class AddNumberOfStartsToRedeem < ActiveRecord::Migration
  def change
    add_column :redeems, :number_of_starts, :integer
  end
end
