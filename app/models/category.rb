class Category < ActiveRecord::Base
	#attr_accessor :name , :discription
	has_many :pitches
	validates :name, :presence => true
end
