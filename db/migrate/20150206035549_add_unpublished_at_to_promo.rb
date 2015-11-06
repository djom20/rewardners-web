class AddUnpublishedAtToPromo < ActiveRecord::Migration
  def change
    add_column :promos, :unpublished_at, :timestamp
  end
end
