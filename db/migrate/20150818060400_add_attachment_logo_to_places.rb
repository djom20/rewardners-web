class AddAttachmentLogoToPlaces < ActiveRecord::Migration
  def self.up
    change_table :places do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :places, :logo
  end
end
