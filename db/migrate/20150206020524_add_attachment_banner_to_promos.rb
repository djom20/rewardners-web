class AddAttachmentBannerToPromos < ActiveRecord::Migration
  def self.up
    change_table :promos do |t|
      t.attachment :banner
    end
  end

  def self.down
    remove_attachment :promos, :banner
  end
end
