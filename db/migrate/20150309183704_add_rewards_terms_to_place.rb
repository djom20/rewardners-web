class AddRewardsTermsToPlace < ActiveRecord::Migration
  def change
    add_column :places, :rewards_terms, :text
  end
end
