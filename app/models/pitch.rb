class Pitch < ActiveRecord::Base
  validates :name, :media_type_id, :category_id, :description, :presence => true
  acts_as_votable

  belongs_to :user
  belongs_to :category
  belongs_to :media_type
  has_many :comments

  # def self.media_types
  #   ["Video","Audio","Written"]
  # end

  # def self.categories
  #   ["Arts","Sports","Politics","Current Events","Education","Entertainment"]
  # end

end
