class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_out_path_for(resource)
    root_path
  end

  def after_sign_in_path_for(resource)
    if resource.name.present?
      flash[:notice] = "ログインしました"
      user_path(resource)
    else
      flash[:notice] = "ユーザー名の登録をお願いします"
      flash[:alert] = "パスワードの入力は不要です"
      edit_user_registration_path
    end
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
