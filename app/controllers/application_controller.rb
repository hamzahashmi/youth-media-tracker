class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

#  before_filter :configure_permitted_parameters, if: :devise_controller?
#
#    protected
#
#        def configure_permitted_parameters
#            devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :gender,:date_of_birth,
#                           :address_zip_code, :address_street, :address_state, :address_city,:phone_number,:bio) }
#            devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :gender,:date_of_birth,
#                           :address_zip_code, :address_street, :address_state, :address_city,:phone_number,:bio) }
#        end
end

