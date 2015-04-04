class Pitch < ActiveRecord::Base
	belongs_to :user, dependent: :destroy
	validates :name, :type, :category, :text,  :presence => true
end
