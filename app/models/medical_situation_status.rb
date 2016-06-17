class MedicalSituationStatus < ActiveRecord::Base
	validates :name, presence: true

	has_many :medical_situations

	def self.options_for_select
	  order('LOWER(name)').map { |e| [e.name, e.id] }
	end

end
