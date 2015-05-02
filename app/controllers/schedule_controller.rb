class ScheduleController < ApplicationController
  def create
    @entry = Schedule.all[0]

    @start_hour = params["start_hour"].to_i
    @start_ampm = params["start_ampm"]
    if @start_ampm == "pm" and @start_hour != 12
      @start_hour += 12
    end

    @end_hour = params["end_hour"].to_i
    @end_ampm = params["end_ampm"]
    if @end_ampm == "pm" and @end_hour != 12
      @end_hour += 12
    end

    @sub_hour = params["sub_hour"].to_i
    @sub_ampm = params["sub_ampm"]
    if @sub_ampm == "pm" and @sub_hour != 12
      @sub_hour += 12
    end

    print @start_hour

    @entry.update(:iteration_start => (DateTime.civil_from_format :local, 2015, 1, 5, @start_hour, params["start_min"].to_i),
                  :iteration_end => (DateTime.civil_from_format :local, 2015, 1, 12, @end_hour, params["end_min"].to_i),
                  :submission_pick => (DateTime.civil_from_format :local, 2015, 1, 13, @sub_hour, params["sub_min"].to_i))
    @entry.save!
    Schedule.update

    flash[:notice] = "Scheduling successfully updated."
	  redirect_to '/admin/scheduling'
  end
end
