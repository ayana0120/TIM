class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  def after_update_path_for(resource)
    user_path(resource)
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:name])
    devise_parameter_sanitizer.permit(:account_update, keys:[:name])
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
