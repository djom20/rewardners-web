class AddStatusToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :status, :string, default: "no_viewed"
  end
end
