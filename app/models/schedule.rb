class Schedule < ActiveRecord::Base
	validates :iteration_start, :iteration_end, :submission_pick, :presence => true
	@entry = Schedule.all[0]

	def self.update
		@entry = Schedule.all[0]
	end

	def self.entry
		@entry = Schedule.all[0]
	end

	def self.iter_start_hour
		@hour = @entry.iteration_start.time.hour % 12
		if @hour == 0
			@hour = 12
		end
		@hour
	end

	def self.iter_start_min
		@entry.iteration_start.time.min
	end

	def self.iter_start_ampm
		@time = "am"
		if @entry.iteration_start.time.hour >= 12
			@time = "pm"
		end
		@time
	end

	def self.iter_end_hour
		@hour = @entry.iteration_end.time.hour % 12
		if @hour == 0
			@hour = 12
		end
		@hour
	end

	def self.iter_end_min
		@entry.iteration_end.time.min
	end

	def self.iter_end_ampm
		@time = "am"
		if @entry.iteration_end.time.hour >= 12
			@time = "pm"
		end
		@time
	end

	def self.sub_pick_hour
		@hour = @entry.submission_pick.time.hour % 12
		if @hour == 0
			@hour = 12
		end
		@hour
	end

	def self.sub_pick_min
		@entry.submission_pick.time.min
	end

	def self.sub_pick_ampm
		@time = "am"
		if @entry.submission_pick.time.hour >= 12
			@time = "pm"
		end
		@time
	end
end
