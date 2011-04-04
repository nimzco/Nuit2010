class CreateStepRequests < ActiveRecord::Migration
  def self.up
    create_table :step_requests do |t|
      t.integer :user_id
      t.integer :trip_id
      t.string :step_address

      t.timestamps
    end
  end

  def self.down
    drop_table :step_requests
  end
end
