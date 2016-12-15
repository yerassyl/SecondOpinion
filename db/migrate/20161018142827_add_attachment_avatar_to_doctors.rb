class AddAttachmentAvatarToDoctors < ActiveRecord::Migration
  def self.up
    change_table :doctors do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :doctors, :avatar
  end
end
