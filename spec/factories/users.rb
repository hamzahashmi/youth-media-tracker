FactoryGirl.define do
  factory :user do
    before (:create) {FactoryGirl.create(:zipcode)}
    confirmed_at Time.now
    name "Test User"
    sequence(:email, 5) { |n| "person#{n}@example.com" }
    password "please123"
    phone_number 123456789
    address_zip_code 12345
    bio "bio"

    trait :admin do
      role 'admin'
    end
    
  end

end
