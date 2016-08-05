class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = t "flash.not_authorized"
    redirect_to root_url
  end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:name]
  end

  def after_sign_in_path_for current_user
    current_user.is_admin? ? admin_exams_path : exams_path
  end

  rescue_from ActiveRecord::RecordNotFound do
    flash[:notice] = t "flash.record_not_found", column_name: params[:id]
    redirect_to root_url
  end

  def current_ability
    namespace = controller_path.split("/").first
    Ability.new current_user, namespace
  end
end
