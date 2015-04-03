class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  validates :name,:address_zip_code,:phone_number,:bio, :presence => true
  validates :bio, length: { maximum: 1000,
                            too_long: "%{count} characters is the maximum allowed" }
  validate :zip_code_is_allowed , :if => :address_zip_code?
  

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  # Accept Del Norte county zip codes only
  def zip_code_is_allowed
    begin
      ZipCode.find_by_zip_code!(self.address_zip_code)
    rescue ActiveRecord::RecordNotFound
      errors.add(:address_zip_code, "is not covered by our service.")
      false
    end
  end
end
