class UserMailer < ApplicationMailer
	default from: "youth.media.tracker@gmail.com"

	def submit_final_work (pitch)
		@user = User.find(pitch.user_id)
		token = SecureRandom.urlsafe_base64
		@medium = @user.media.create!(:token => token, :due_date => 2.weeks.from_now)
		mail(to: @user.email, subject: 'Congratulation | You\'re Pitch got selected')
	end

end
