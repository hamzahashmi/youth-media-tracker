class ScheduleController < ApplicationController
  def create
  	schedule_weeks = params["schedule_weeks"].to_i
  	pitch_day = params["pitch_day"].to_i
  	disc_day = params["disc_day"].to_i
  	archive_days = params["archive_days"].to_i
  	if schedule_weeks < 0
  		flash[:notice] = "Invalid number of weeks"
  	elsif pitch_day < 0 or pitch_day > schedule_weeks * 7
  		flash[:notice] = "Enter pitch day between 0 and number of weeks"
  	elsif disc_day < 0 or disc_day > schedule_weeks * 7
  		flash[:notice] = "Enter discussion day between 0 and number of weeks"
  	elsif archive_days < 0
  		flash[:notice] = "Invalid archive days"
  	else
	  	Rails.application.config.schedule_weeks = schedule_weeks
	  	Rails.application.config.pitch_day = pitch_day
	  	Rails.application.config.disc_day = disc_day
	  	flash[:notice] = "Scheduling successfully updated."
	end
	  redirect_to '/admin'
  end
end
