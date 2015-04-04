module DevisePermittedParameters
  extend ActiveSupport::Concern

  included do
    before_filter :configure_permitted_parameters
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :gender,:date_of_birth, 
            								:address_zip_code, :address_street, :address_state, :address_city,:phone_number,:bio ,:current_password,:password_confirmation) }
            devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :gender,:date_of_birth, 
            								:address_zip_code, :address_street, :address_state, :address_city,:phone_number,:bio,:current_password,:password_confirmation) }
  end

end

DeviseController.send :include, DevisePermittedParameters
