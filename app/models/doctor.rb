class Doctor < ActiveRecord::Base
  validates :name,
            :email,
            :phone_number,
            :address,
            presence: true

  mount_uploader :resume, ResumeUploader

  attr_accessor :resume_cache

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100> "}, default_url: ":style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  belongs_to :user
  has_many :medical_situations
  has_many :medical_services
  has_many :medical_situation_reports

  has_many :doctor_specializations
  has_many :specializations, through: :doctor_specializations


end
