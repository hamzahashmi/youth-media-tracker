# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# 

#Scheduling
iteration_start = DateTime.civil(2015, 1, 5, 12, 0, 0, Rational(-8, 24))
iteration_end = DateTime.civil(2015, 1, 12, 12, 0, 0, Rational(-8, 24))
submission_pick = DateTime.civil(2015, 1, 13, 17, 0, 0, Rational(-8, 24))
Schedule.delete_all
Schedule.create!(:iteration_start => iteration_start,
                 :iteration_end => iteration_end,
                 :submission_pick => submission_pick)

media_types_list = ["Video","Audio","Written"]
media_types_list.each do |type|
	MediaType.create!(:name => type) if !MediaType.exists?(:name => type)
end

categories_list = ["Arts","Sports","Politics","Current Events","Education","Entertainment"]
categories_list.each do |category|
	Category.create!(:name => category) if !Category.exists?(:name => category)
end

zip_codes_list = [[95531,"Del Norte"],
				[95532,"Del Norte"],
				[95538,"Del Norte"],
				[95543,"Del Norte"],
				[95548, "Del Norte"],
				[95567, "Del Norte"],]
zip_codes_list.each do |code, county|
	 Zipcode.create(:code => code, :county => county) if !Zipcode.exists?(:code => code)
end
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email if !user.nil?
# Environment variables (ENV['...']) can be set in the file .env file.