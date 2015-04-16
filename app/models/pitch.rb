class Pitch < ActiveRecord::Base
  validates :name, :media, :category, :description, :presence => true
  acts_as_votable

  belongs_to :user
  has_many :comments

  def self.media_types
    ["Video","Audio","Written"]
  end

  def self.categories
    ["Arts","Sports","Politics","Current Events","Education","Entertainment"]
  end

end
