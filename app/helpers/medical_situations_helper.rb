module MedicalSituationsHelper

  def medical_situation_class
    ( current_page?(controller: :medical_situations, action: :index) or
        current_page?(controller: :medical_situations, action: :in_pool) or
        current_page?(controller: :medical_situations, action: :not_in_pool)
    ) ? 'show' : 'hide'
  end

end
