class Allergy < ActiveRecord::Base
  # note: this class describes relation of allergy to particular patient
  # it is not allergies database
  belongs_to :patient

end
