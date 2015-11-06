class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.references :category, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
