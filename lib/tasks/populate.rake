namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    [Comment, Pitch, User, Zipcode].each(&:delete_all)
    
    zip_codes_list = [[95531,"Del Norte"],
    [95532,"Del Norte"],
    [95538,"Del Norte"],
    [95543,"Del Norte"],
    [95548, "Del Norte"],
    [95567, "Del Norte"],]
    zip_codes_list.each do |code, county|
     Zipcode.create(:code => code, :county => county) if !Zipcode.exists?(code)
   end
   CreateAdminService.new.call

   User.populate 40 do |user|
    user.name    = Faker::Name.name
    user.email   = Faker::Internet.email
    user.encrypted_password = Faker::Internet.password
    user.phone_number   = Faker::PhoneNumber.phone_number
    user.gender   = [0,1,2]
    user.date_of_birth = Faker::Date.between(21.years.ago, 10.years.ago)
    user.address_street  = Faker::Address.street_address
    user.address_state   = "CA"
    user.address_zip_code  = Zipcode.order("RANDOM()").first.code
    user.bio = Populator.sentences(2..4)
    user.created_at = Faker::Date.between(10.months.ago, 2.days.ago)
    user.confirmed_at = user.created_at + 2.hours
    user.sign_in_count = 1..30
    user.suspended = false
  end

  Pitch.populate 5..30 do |pitch|
    pitch.name = Populator.words(1..5).titleize
    pitch.description = Populator.sentences(2..4)
    pitch.category = Pitch.categories
    pitch.media = Pitch.media_types
    user = User.order("RANDOM()").first
    pitch.user_id = user.id
    pitch.created_at = user.created_at..Time.now
    ActsAsVotable::Vote.populate 4..30 do |vote|
      vote.votable_id =  pitch.id
      vote.votable_type = "Pitch"
      vote.voter_id = User.order("RANDOM()").first.id
      vote.voter_type =  "User"
      vote.vote_flag = [true, false].sample
      vote.vote_scope = nil
      vote.vote_weight = 1
    end
    Comment.populate 5..10 do |comment|
      comment.body = Populator.sentences(1..3)
      user = User.order("RANDOM()").first
      comment.user_id = user.id
      comment.pitch_id = pitch.id
      comment.created_at =  pitch.created_at..Time.now
    end
  end
end

end