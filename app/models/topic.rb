class Topic < ActiveRecord::Base
	belongs_to :forum
	belongs_to :user
	has_many :posts
	
	validates_presence_of :user_id
	validates_presence_of :description
	validates_presence_of :title
	validates_presence_of :forum_id

end
