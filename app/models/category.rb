class Category < ActiveRecord::Base
	has_many :pitches
	validates :name, :presence => true

	def self.categories_list
		self.all.map { |m| [m.name,m.id] }
	end
end
