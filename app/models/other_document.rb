class OtherDocument < ActiveRecord::Base
  # has_attached_file :file
  #
  # validates :name, presence: true
  #
  # validates :file, attachment_presence: true
  # validates_attachment :file, content_type: { content_type: ['image/jpg', 'application/pdf'] }
  mount_uploader :file, OtherDocumentUploader

  belongs_to :medical_history

end
