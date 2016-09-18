class MedicalSituationReport < ActiveRecord::Base

  mount_uploader :file, MedicalSituationReportUploader
  attr_accessor :file_cache

  belongs_to :medical_situation
  belongs_to :doctor

  validates :file, :name, presence:true
end
