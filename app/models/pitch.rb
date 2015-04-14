class Pitch < ActiveRecord::Base
	validates :name,:media,:category,:text, :presence => true
	acts_as_votable

	belongs_to :user
	has_many :comments
end
