class ScheduleController < ApplicationController
  def create
  	schedule_days = params["schedule_days"].to_i
  	pitch_day = params["pitch_day"].to_i
  	disc_day = params["disc_day"].to_i
  	archive_days = params["archive_days"].to_i
  	if schedule_days < 0
  		flash[:notice] = "Invalid number of days per iteration."
  	elsif pitch_day < 0 or pitch_day > schedule_days
  		flash[:notice] = "Enter pitch day between 0 and number of days per iteration."
  	elsif disc_day < 0 or disc_day > schedule_days
  		flash[:notice] = "Enter discussion day between 0 and number of days per iteration."
  	elsif archive_days < 0
  		flash[:notice] = "Invalid archive days."
  	else
	  	Rails.application.config.schedule_days = schedule_days
	  	Rails.application.config.pitch_day = pitch_day
	  	Rails.application.config.disc_day = disc_day
	  	flash[:notice] = "Scheduling successfully updated."
	end
	  redirect_to '/admin/scheduling'
  end
end
