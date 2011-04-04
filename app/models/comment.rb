class Comment < ActiveRecord::Base
	belongs_to :author, :class_name => 'User', :foreign_key => 'authorid'
	belongs_to :user, :class_name => 'User', :foreign_key => 'user_id'
end
