class AddZoom < ActiveRecord::Migration
  def self.up
		add_column :google_maps, :zoom, :integer
  end

  def self.down
		remove_column :google_maps, :zoom
  end
end
