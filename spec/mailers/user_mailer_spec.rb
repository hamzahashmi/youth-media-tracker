require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
	it "should send email" do
	user = FactoryGirl.create(:user ,:email => "ex@ample.com")
	pitch = FactoryGirl.create(:pitch, :user => user)
  	email = UserMailer.submit_final_work(pitch).deliver_now
  	ActionMailer::Base.deliveries.should_not be_empty
  	email.to.first.should eq("ex@ample.com")
  	email.body.to_s.should have_content("Congratulation")
  end

end
