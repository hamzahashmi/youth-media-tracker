class Schedule < ActiveRecord::Base
	validates :iteration_start, :iteration_end, :submission_pick, :presence => true

	if Schedule.all.length == 0
		iteration_start = DateTime.civil(2015, 1, 5, 12, 0, 0, Rational(-8, 24))
		iteration_end = DateTime.civil(2015, 1, 12, 12, 0, 0, Rational(-8, 24))
		submission_pick = DateTime.civil(2015, 1, 13, 17, 0, 0, Rational(-8, 24))
		Schedule.delete_all
		Schedule.create!(:iteration_start => iteration_start,
		                 :iteration_end => iteration_end,
		                 :submission_pick => submission_pick)
	end

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

	def self.iter_start
		@start = @entry.iteration_start
		while (@start - DateTime.current) < 0
			@start = @start.advance :weeks => 1
		end
		@start = @start.advance :weeks => -1
	end

	def self.iter_end
		@end = @entry.iteration_end
		while @end - DateTime.current < 0
			@end = @end.advance :weeks => 1
		end
		@end
	end
end
