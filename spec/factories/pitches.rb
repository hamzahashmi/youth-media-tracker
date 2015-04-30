FactoryGirl.define do
  factory :pitch do
      name "testName"
      #Doesn't quite work, have to actually replace
	  media_type FactoryGirl.create(:media_type)
	  category FactoryGirl.create(:category)
	  description "testText"
	  user
  end

end
