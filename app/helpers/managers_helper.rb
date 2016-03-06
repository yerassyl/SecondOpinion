module ManagersHelper

  def client_call_backs_sub_nav_link
    ddclass = ''
    ddclass = 'active' if current_page?(managers_path) or
        current_page?(controller: :managers, action: :index) or
        current_page?(controller: :managers, action: :accepted) or
        current_page?(controller: :managers, action: :rejected)
    disabled = ''
    disabled = 'disabled' if ddclass=='active'
    content_tag('dd', link_to( t('client_callbacks'), managers_path,  html: {disabled: disabled}),class: ddclass)
  end

  def doctor_module_sav_nav_lin
    ddclass = ''
    ddclass = 'active' if current_page?(controller: :doctors, action: :index)
    disabled = ''
    disabled = 'disabled' if ddclass=='active'
    content_tag('dd', link_to(t('module.doctor'),doctors_path, html: {disabled: disabled}) ,class:ddclass)
  end


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



end
