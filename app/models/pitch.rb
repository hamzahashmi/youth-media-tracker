class Pitch < ActiveRecord::Base
	belongs_to :user, dependent: :destroy
	validates :name, :type, :category, :text,  :presence => true
	allowed_categories = ["Arts","Sports","Political","Current Events"]
	allowed_types = ["Audio","Video","Written"]


end
