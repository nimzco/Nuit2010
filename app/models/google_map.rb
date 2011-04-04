class GoogleMap < ActiveRecord::Base
	has_many :google_markers
	validates_presence_of :title , :message => "Vous devez renseigner un titre"
	validates_presence_of :address
	validates_presence_of :zoom
	validates_inclusion_of :zoom,
							:in => [4, 6, 8, 10, 13, 16, 18],
							:message => "should be availables"
	
	@@zooms = [["Continent", 4], ["Pays", 6], ["Region", 8], ["Departement", 10], ["Ville", 13], ["Quartier", 16], ["Site", 18]]
	def self.zooms
		return @@zooms
	end
end
