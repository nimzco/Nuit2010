class Forum < ActiveRecord::Base
	has_many :topics
	belongs_to :user

	validates_presence_of :user_id
	validates_presence_of :name
	validates_presence_of :description

end
