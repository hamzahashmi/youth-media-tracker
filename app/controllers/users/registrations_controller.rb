class Users::RegistrationsController < Devise::RegistrationsController
before_filter :configure_sign_up_params, only: [:create]
before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource/sign_up
  def create
    user = User.find_by_email(sign_up_params['email'])
    super and return unless !user.nil? && user.suspended?
    self.resource = resource_class.new(sign_up_params)
    sign_out
    flash[:error] = 'Your account has been suspended by admin.'
    respond_with_navigational(resource) { render :new }
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # You can put the params you want to permit in the empty array.
    def configure_sign_up_params
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :gender,:date_of_birth,:address_zip_code, :address_street, :address_state, :address_city,:phone_number,:bio,:password_confirmation,:photo) }
    end

  # You can put the params you want to permit in the empty array.
    def configure_account_update_params
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :gender,:date_of_birth,:address_zip_code, :address_street, :address_state, :address_city,:phone_number,:bio,:password_confirmation,:current_password,:photo) }
    end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
