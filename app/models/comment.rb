class Comment < ActiveRecord::Base
  validates :body, :user, :pitch,:presence => true
  belongs_to :user
  belongs_to :pitch
end
