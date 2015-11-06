class CreateRedeemTakenPromos < ActiveRecord::Migration
  def change
    create_table :redeem_taken_promos do |t|
      t.references :taken_promo, index: true
      t.references :redeem, index: true

      t.timestamps
    end
  end
end
