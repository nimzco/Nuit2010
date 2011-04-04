class CreateGoogleMarkers < ActiveRecord::Migration
  def self.up
    create_table :google_markers do |t|
      t.integer :google_map_id
	  t.string :address
      t.string :title
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :google_markers
  end
end
