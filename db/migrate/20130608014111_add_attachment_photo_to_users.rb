class AddAttachmentPhotoToUsers < ActiveRecord::Migration
  def self.up
    change_table :user_photos do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :user_photos, :photo
  end
end
