class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?


  has_many :pitches
  has_many :media

  acts_as_voter

  validates :name,:address_zip_code,:phone_number,:bio, :presence => true
  validates :bio, length: { maximum: 1000,
                            too_long: "%{count} characters is the maximum allowed" }
  validate :zip_code_is_allowed , :if => :address_zip_code?
  validates :agreement, acceptance: true
  GENDER_TYPES = [ ["Do not wish to say",0],["Male",1], [ "Female",2 ]  ]
  validates :gender, inclusion: { in: [0,1,2] }, :if => :gender?

  has_attached_file :photo, :styles => { :medium => "300x300", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

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
      Zipcode.find_by_code!(self.address_zip_code)
    rescue ActiveRecord::RecordNotFound
      errors.add(:address_zip_code, "is not covered by our service.")
      false
    end
  end
  def is_admin?
    true if self.admin?
  end

end
