class AddAttachmentBannerToPlaces < ActiveRecord::Migration
  def self.up
    change_table :places do |t|
      t.attachment :banner
    end
  end

  def self.down
    remove_attachment :places, :banner
  end
end
