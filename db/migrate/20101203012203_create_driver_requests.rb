class CreateDriverRequests < ActiveRecord::Migration
  def self.up
    create_table :driver_requests do |t|
      t.integer :user_id
      t.integer :trip_id

      t.timestamps
    end
  end

  def self.down
    drop_table :driver_requests
  end
end
