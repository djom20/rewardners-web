class CreateTakenPromos < ActiveRecord::Migration
  def change
    create_table :taken_promos do |t|
      t.references :user, index: true
      t.references :promo, index: true

      t.timestamps
    end
  end
end
