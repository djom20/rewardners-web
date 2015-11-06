class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :paypal_payer_id
      t.string :paypal_profile_id
      t.references :plan, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.datetime :paid_until
      t.boolean :canceled, default: false
      t.boolean :free, default: false

      t.timestamps null: false
    end
  end
end
