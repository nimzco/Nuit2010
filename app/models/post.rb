class Post < ActiveRecord::Base
	belongs_to :topic
	belongs_to :user
	
	validates_presence_of :user_id
	validates_presence_of :topic_id
	
end
