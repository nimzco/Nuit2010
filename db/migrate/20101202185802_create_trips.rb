class CreateTrips < ActiveRecord::Migration
  def self.up
    create_table :trips do |t|
      t.integer :user_id
      t.string :start_address
      t.string :end_address
      t.boolean :on_demand
      t.datetime :start_date
      t.datetime :end_date
      t.integer :seat

      t.timestamps
    end
  end

  def self.down
    drop_table :trips
  end
end
