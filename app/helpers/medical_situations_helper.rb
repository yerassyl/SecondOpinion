module MedicalSituationsHelper

  def medical_situation_class
    current_page?(controller: :medical_situations, action: :index) ? 'show' : 'hide'
  end

end
