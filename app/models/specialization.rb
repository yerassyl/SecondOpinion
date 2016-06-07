class Specialization < ActiveRecord::Base
  has_many :medical_services

  has_many :doctor_specializations
  has_many :doctors, through: :doctor_specializations
  has_many :medical_situations

  def self.options_for_select
	  order('LOWER(name)').map { |e| [e.name, e.id] }
	end
  
end
