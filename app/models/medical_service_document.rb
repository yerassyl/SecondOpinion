class MedicalServiceDocument < ActiveRecord::Base

  mount_uploader :file, MedicalServiceDocumentUploader
  belongs_to :medical_services

  attr_accessor :file_cache

  validates :file, presence:true

end
