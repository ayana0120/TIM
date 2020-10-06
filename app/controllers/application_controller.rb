class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

    def after_sign_out_path_for(resource)
      root_path
    end

    def after_sign_in_path_dor(resource)
      user_path(resource)
    end

    private

    def configure_parmitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys:[:name])
    end

end
