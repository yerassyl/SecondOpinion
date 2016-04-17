class Doctor < ActiveRecord::Base
  validates :name,
            :email,
            :resume,
            :phone_number,
            presence: true

  mount_uploader :resume, ResumeUploader
  validates :name, presence: true
  validates :email, presence: true
  validates :resume, presence: true
  validates :phone_number, presence: true

  attr_accessor :resume_cache

  belongs_to :user
  has_many :medical_situations

end
