class AddPromoCodeToTakenPromo < ActiveRecord::Migration
  def change
    add_column :taken_promos, :promo_code, :string
  end
end
