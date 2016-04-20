module ApplicationHelper

  def print_role(user)
    user.roles.first.name
  end

  # HEADER HELPERS

  # user profile depending on it's role
  def user_profile
    if current_user.has_role?(:admin)
    elsif current_user.has_role?(:manager)
    elsif current_user.has_role?(:client)
        client_path(current_user.client.id)
    elsif current_user.has_role?(:doctor)
        doctor_path(current_user.doctor.id)
    else # patient

    end
  end

  # edit profile link depending on user's role
  def edit_profile
    if current_user.has_role?(:client)
      edit_client_path(current_user.client)
    elsif current_user.has_role?(:doctor)
      edit_doctr_path(current_user.doctor)
    else

    end
  end

end
