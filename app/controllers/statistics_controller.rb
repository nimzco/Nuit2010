class StatisticsController < ApplicationController
	
	
  def index
#	  draw_me_a_table
#		draw_me_a_line_chart
		offre_demande
  end
  
	##	Table type example:
	##				User_type	|	Number_of_Male |	Number_of_Female
	##
	##				Admin			|				4				 |				3
	##				Normal		|			 24			 	 |			 33
	##
	
	def offre_demande
		@table = StatisticsTable.new
		@table.title = "Offre et demande"
		@table.axis_title = "Nombre d utilisateurs"
				
		@table.add_header('string','')
		@table.add_header('number','Offre')
		@table.add_header('number','Demande')

		@offre = 0
		@trips = Trip.find(:all, :conditions => ['on_demand = FALSE'])
		@trips.each do |trip|
			@offre += trip.seat 
		end
		
		@demande = Trip.find(:all, :conditions => ['on_demand = TRUE']).size
		@trips.each do |trip|
			@demande += trip.users.size
		end 
		@table.add_line(["Nombre d utilisateurs", @offre, @demande])
	end
	
	
	def taux_de_remplissage
		@table = StatisticsTable.new
		@table.title = "Taux de remplissage"
		@table.axis_title = "Nombre d utilisateur"
				
		@table.add_header('string','')
		@table.add_header('number','Nombre de place')
#		@table.add_header('number','Place utilisés')

		@nb_propose = 0
		@trips = Trip.find(:all, :conditions => ['on_demand = FALSE'])
		@trips.each do |trip|
			@nb_propose += trip.seat - 1 # -1 for the driver
		end
		
		@nb_place_effective = 0
		@trips.each do |trip|
			@nb_place_effective += trip.users.size
		end 
		@total = @nb_place_effective.to_f / @nb_propose.to_f
		@table.add_line(["Place proposé", 1 - @total])
		@table.add_line(["Place utilisé", @total])
	end
	
	
	def nombre_inscrit_par_communaute
		@table = StatisticsTable.new
		@table.title = "Nombre d inscrit par communaute"
		@table.axis_title = "Nombre d inscrit"
				
		@table.add_header('string','Nom de la communauté')
		@table.add_header('number',"Nombre d inscrit")
		
		@comunities = Comunity.all
		@comunities.each do |comunity|
			@table.add_line([comunity.name.gsub(/'/," "), comunity.users.size])
		end
	end
	
	def nombre_trajet_par_communaute
		@table = StatisticsTable.new
		@table.title = "Nombre de trajet par communauté"
		@table.axis_title = "Nombre de trajet"
				
		@table.add_header('string','Nom de la communauté')
		@table.add_header('number','Nombre de trajet')
		
		@comunities = Comunity.all
		@comunities.each do |comunity|
			
			@nb_trip = 0
			@users = User.find_all_by_comunity_id(comunity.id)
			@users.each do |user|
				@nb_trip += Trip.find_all_by_user_id(user.id).size
			end
			@table.add_line([comunity.name.gsub(/'/," "), @nb_trip])
		end
	end
	
	
	## Example 
	##	Salary/Time
	##					| 	Paul  |	 Joe	 | 	Jean
	##	January	|	10000		| 20000	 |	23000
	##	February|	10000		| 20000	 |	23000
	##	March		|	10000		| 20000	 |	23000
	##	April		|	10000		| 20000	 |	23000
	##
	
	def draw_me_a_line_chart
		@table = StatisticsTable.new
		@table.title = 'Statistiques'
		@table.axis_title = 'money'
		
		@table.add_header('string','Name')
		@table.add_header('number','Paul')
		@table.add_header('number','Joe')
		@table.add_header('number','Jean')

		@table.add_line(['January', 10000, 20000, 23000])
		@table.add_line(['February', 9000, 22000, 24000])
		@table.add_line(['March', 8000, 25000, 21000])
		@table.add_line(['April', 7000, 29000, 22000])
		@table.add_line(['May', 6000, 40000, 23000])
	end
	
end