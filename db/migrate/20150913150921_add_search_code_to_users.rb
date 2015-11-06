class AddSearchCodeToUsers < ActiveRecord::Migration
  def up
    add_column :users, :search_code, :string
    User.all.each do |user|
      user.update(search_code: CouponCode.generate)
    end

  end

  def down
    remove_column :users, :search_code
  end
end
