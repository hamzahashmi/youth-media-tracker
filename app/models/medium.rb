class Medium < ActiveRecord::Base
	validates :token, :user_id, :due_date,:presence => true
	belongs_to :user
end
