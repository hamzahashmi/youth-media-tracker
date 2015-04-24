class CreateAdminService
  def call

    if !User.exists?(:email => Rails.application.secrets.admin_email) 
    	email = Rails.application.secrets.admin_email
        password = Rails.application.secrets.admin_password
        password_confirmation = Rails.application.secrets.admin_password
        name = "YouthZone Del Norte"
        address_zip_code = 95531
        phone_number = 1234567890
        bio = "This is the admin"
        user = User.create!(:name => name, :password => password, :password_confirmation => password_confirmation, 
        					:address_zip_code => address_zip_code, :bio => bio, :phone_number => phone_number, :email => email)
        user.confirm!
        user.admin!
        return user
      end
      return nil
  end
end