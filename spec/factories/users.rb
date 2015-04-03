FactoryGirl.define do
  factory :user do
    confirmed_at Time.now
    name "Test User"
    email "test@example.com"
    password "please123"
    phone_number 123456789
    address_zip_code 12345
    bio "bio"

    trait :admin do
      role 'admin'
    end
    
  end
end
