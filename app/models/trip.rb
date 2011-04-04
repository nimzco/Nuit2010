class Trip < ActiveRecord::Base

	has_and_belongs_to_many :users
	belongs_to :driver, :class_name => 'User', :foreign_key => 'user_id'
	has_many :driver_requests
	has_many :step_requests
	has_many :steps
	
	def not_old?
		return (start_date >= Time.now)
	end
	
end
