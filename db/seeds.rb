# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# 
zip_codes_list = [[95531,"Del Norte"],
				[95532,"Del Norte"],
				[95538,"Del Norte"],
				[95543,"Del Norte"],
				[95548, "Del Norte"],
				[95567, "Del Norte"],]
zip_codes_list.each do |code, county|
	 Zipcode.create(:code => code, :county => county) if !Zipcode.exists?(code)
end
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email if !user.nil?
# Environment variables (ENV['...']) can be set in the file .env file.
