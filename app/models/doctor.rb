class Doctor < ActiveRecord::Base
  validates :name,
            :email,
            #:resume,
            :phone_number,
            :address,
            presence: true

  mount_uploader :resume, ResumeUploader

  attr_accessor :resume_cache

  belongs_to :user
  has_many :medical_situations
  has_many :medical_services

  has_many :doctor_specializations
  has_many :specializations, through: :doctor_specializations


end
