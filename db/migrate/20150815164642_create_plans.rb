class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name_es
      t.string :name_en
      t.float :price
      t.text :description_es
      t.text :description_en
      t.string :paypal_description_es
      t.string :paypal_description_en

      t.timestamps null: false
    end
  end
end
