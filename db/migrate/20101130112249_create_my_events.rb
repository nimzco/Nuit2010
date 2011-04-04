class CreateMyEvents < ActiveRecord::Migration
	def self.up
		create_table :my_events do |t|
			t.integer :event
			t.string :calendar
			
			t.integer :user_id
			
			
			t.timestamps
		end
	end

	def self.down
		drop_table :my_events
	end
end
