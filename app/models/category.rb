class Category < ActiveRecord::Base
	attr_accessor :name , :description
	has_many :pitches
	validates :name, :presence => true
end
