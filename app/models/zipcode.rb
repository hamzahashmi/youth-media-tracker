class Zipcode < ActiveRecord::Base
	def to_s
    	"Code:#{self.code} County:#{self.county} "
  	end
end
