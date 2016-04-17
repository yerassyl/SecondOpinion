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
    elsif current_user.has_role?(:doctor)
        doctor_path(current_user.doctor.id)
    else # patient

    end
  end

end
