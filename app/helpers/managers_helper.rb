module ManagersHelper

  def client_call_backs_sub_nav_link
    ddclass = (
        current_page?(managers_path) or
        current_page?(controller: :managers, action: :index) or
        current_page?(controller: :managers, action: :accepted) or
        current_page?(controller: :managers, action: :rejected)
        ) ? 'active' : ''
    disabled = ddclass== 'active' ? 'disabled' : ''
    content_tag('dd', link_to( t('client_callbacks'), managers_path,  html: {disabled: disabled}),class: ddclass)
  end

  # client_callbacks -> sub nav links
  def incoming_sub_nav_link
    'active' if current_page?(managers_path) or
        current_page?(controller: :managers, action: :index)
  end

  def accepted_sub_nav_link
    'active' if current_page?(controller: :managers, action: :accepted)
  end

  def rejected_sub_nav_link
    'active' if current_page?(controller: :managers, action: :rejected)
  end



  def doctor_module_sub_nav_link
    ddclass = current_page?(controller: :doctors, action: :index) ? 'active' : ''
    disabled = ddclass=='active' ? 'disabled' : ''
    content_tag('dd', link_to(t('doctor_module'),doctors_path, html: {disabled: disabled}) ,class: ddclass)
  end

  def cases_module_sub_nav_link
    ddclass = ( current_page?(controller: :medical_situations, action: :index) or
                current_page?(controller: :medical_situations, action: :in_pool) or
                current_page?(controller: :medical_situations, action: :not_in_pool)
              ) ? 'active' : ''
    disabled = ddclass=='active' ? 'disabled' : ''
    content_tag('dd', link_to(t('cases_module'), medical_situations_path, html: {disabled: disabled} ), class: ddclass)
  end

  # cases_module -> sub nav links
  # medical situations sub nav links
  def all_situations_sub_nav_link
    current_page?(controller: :medical_situations, action: :index) ? 'active' : ''
  end

  def in_pool
    current_page?(controller: :medical_situations, action: :in_pool) ? 'active' : ''
  end

  def not_in_pool
    current_page?(controller: :medical_situations, action: :not_in_pool) ? 'active' : ''
  end


end
