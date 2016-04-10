class Doctor < ActiveRecord::Base


  mount_uploader :resume, ResumeUploader
  validates :name, presence: true
  validates :email, presence: true
  validates :resume, presence: true
  validates :phone_number, presence: true

  belongs_to :user

  attr_accessor :resume_cache

end
