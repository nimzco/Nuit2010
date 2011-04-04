class AddColorInMarker < ActiveRecord::Migration
  def self.up
		add_column :google_markers, :color, :string
  end

  def self.down
		remove_column :google_markers, :color
  end
end
