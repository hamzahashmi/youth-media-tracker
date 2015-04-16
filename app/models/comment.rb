class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :pitch, counter_cache: true
end
