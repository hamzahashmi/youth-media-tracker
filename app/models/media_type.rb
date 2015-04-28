class MediaType < ActiveRecord::Base
	has_many :pitches
	validates :name, :presence => true
end
