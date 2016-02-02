module ApplicationHelper

  def print_role(user)
    user.roles.first.name
  end

end
