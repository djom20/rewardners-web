class CreateRedeems < ActiveRecord::Migration
  def change
    create_table :redeems do |t|
      t.integer :approved_by
      t.references :user, index: true
      t.references :place, index: true
      t.text :description
      t.timestamp :approved_at
      t.timestamp :rejected_at
      t.integer :rejected_by
      t.text :rejected_reason

      t.timestamps
    end
  end
end
