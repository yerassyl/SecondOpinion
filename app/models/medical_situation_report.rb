class MedicalSituationReport < ActiveRecord::Base

  mount_uploader :file, MedicalSituationReportUploader
  attr_accessor :file_cache

  belongs_to :medical_situation

  validates :file, presence:true
end
