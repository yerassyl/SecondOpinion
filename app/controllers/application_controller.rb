class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # if useer is not authorized to access some module
  rescue_from CanCan::AccessDenied do |exception|
    # use main_app. with rails_admin engine
    #redirect_to main_app.access_denied_path, :alert => exception.message
    redirect_to access_denied_path, :alert => exception.message
  end


  rescue_from ActiveRecord::RecordNotFound do
    flash[:warning] = I18n.t('warnings.resource_not_found')
    redirect_back_or root_path
  end

  def redirect_back_or(path)
    redirect_to request.referer || path
  end


  protected

  # redirecting to appropriate url based on role
  def after_sign_in_path_for(resource)
    if current_user.has_role?(:admin)
      clients_path
    elsif current_user.has_role?(:client)
    elsif current_user.has_role?(:patient)
    elsif current_user.has_role?(:manager)
      managers_path
    elsif current_user.has_role?(:doctor)
    else
      root_path
    end
  end

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end


end
