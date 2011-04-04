class GoogleMarker < ActiveRecord::Base
	belongs_to :google_map
	validates_presence_of :title
	validates_presence_of :address
	validates_presence_of :google_map_id
	validates_associated :google_map
	validates_presence_of :color
	validates_inclusion_of :color,
							:in => ["blue", "orange", "red", "green", "purple",  "yellow"],
							:message => "should be availables"

	
	
	@@colors = {"Bleu" => "blue", "Orange" => "orange", "Rouge" => "red", "Vert" => "green", "Violet" => "purple", "Jaune" => "yellow"}
	def self.colors
		return @@colors
	end
end
