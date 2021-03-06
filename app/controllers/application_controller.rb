class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery

  after_filter :set_csrf_cookie_for_ng

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  #REQUIRED TO USE DEVISE WITH CUSTOM FIELD INPUT
  before_action :configure_permitted_parameters, if: :devise_controller?

  #Helper Methods for user authentification
  helper_method :person_signed_in?, :vendor_signed_in?

  def vendor_signed_in?
    user_signed_in? and current_user.vendor?
  end

  def person_signed_in?
    user_signed_in? and current_user.person?
  end

  protected

  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

  #SPECIFY PARAMS FOR DEVISE TO USE
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :location, :email, :password,
               :password_confirmation, :current_password, :zip_code, :vendor, :picture)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:name, :location, :email, :password,
               :password_confirmation, :current_password, :zip_code, :vendor, :picture, :bio, :description)
    end
  end

  #REDIRECT DEVISE AFTER SIGN IN
  def after_sign_in_path_for(resource)
    if resource.rolable.class.name == "Person"
      return root_path
    elsif resource.rolable.class.name == "Vendor"
      if current_user.rolable.confirmed == false
        return confirm_details_vendors_path
      else
        return root_path
      end
    else
      return root_path
    end
  end
end
