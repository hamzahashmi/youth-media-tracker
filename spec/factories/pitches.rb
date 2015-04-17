FactoryGirl.define do
  factory :pitch do
      name "testName"
	  media "testMedia"
	  category "testCategory"
	  description "testText"
	  user
  end

end
