# Description/Explanation of ApplicationController class
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parrameters,
                if: :devise_controller?

  protected

  def configure_permitted_parrameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[avatar name email password])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[avatar name email password current_password])
  end
end
