class CreatePromos < ActiveRecord::Migration
  def change
    create_table :promos do |t|
      t.string :name
      t.text :description
      t.references :place, index: true
      t.boolean :published
      t.timestamp :published_at
      t.references :role, index: true
      t.timestamp :start_at
      t.timestamp :end_at
      t.text :extra_description

      t.timestamps
    end
  end
end
