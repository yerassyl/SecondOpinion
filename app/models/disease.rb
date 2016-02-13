class Disease < ActiveRecord::Base
  # note: this class describes relation of disease to particular patient
  # it is not disease database
  belongs_to :patient

end
