class AddComunity < ActiveRecord::Migration
  def self.up
		Comunity.delete_all
		Comunity.create(:name => "Université de Lille", :address => "Lille, France", :keywords => "Lille", :description => "Située sur un campus verdoyant de 110 hectares, elle se trouve sur le domaine universitaire Cité Scientifique de Villeneuve-d'Ascq, au sud-est de la métropole lilloise. L’Université Lille-Nord de France est un Pôle de recherche et d'enseignement supérieur (PRES) au statut d’Établissement public de coopération scientifique1. Le conseil d'administration du PRES Université Lille Nord de France compte les 8 membres fondateurs ainsi que 6 associés (Skema Business School, INRIA, FUPL, CHRU, Institut Pasteur de Lille, ENSAIT)")
		Comunity.create(:name => "Université Joseph Fourier", :address => "Grenoble, France", :keywords => "Grenoble", :description => "L’université Joseph-Fourier (souvent nommée UJF ou, plus anciennement, université Grenoble-I) est une université en sciences, technologies et santé, et ayant son siège à Grenoble en France. L'UJF se situe historiquement dans la lignée de la faculté de sciences fondée à Grenoble en 1811 par Joseph Fourier, à partir de laquelle elle a été créée en 1970
")
		Comunity.create(:name => "Polytech'Nice Sophia", :address => "Sophia Antipolis, France", :keywords => "Nice Sophia Polytech", :description => "Polytech'Nice-Sophia est une école d'ingénieurs au sein de l'Université de Nice - Sophia Antipolis. Sur le site de la technopole de Sophia Antipolis, Polytech'Nice-Sophia est au centre d'une synergie Enseignement - Recherche - Industrie au sein du futur campus STIC1.")
		Comunity.create(:name => "Ecole Nationale Supérieure des Mines de St Etienne", :address => "St Etienne, France", :keywords => "St Etienne", :description => "L'École nationale supérieure des Mines de Saint-Étienne (ENSM SE) est une école d'ingénieurs française à vocation généraliste créée en 1816. Elle fait partie du Groupe des Écoles des Mines (GEM), sous tutelle du ministère de l’Economie, de l'Industrie et de l’Emploi (ministère de l'industrie).")
		Comunity.create(:name => "UTC Compiègne", :address => "Compiègne, France", :keywords => "UTC Compiègne", :description => "")
		Comunity.create(:name => "Université de Reims Champagne Ardenne", :address => "Charleville-Mézières, France", :keywords => "Reims", :description => "L'université de Reims Champagne-Ardenne (URCA) est une université française pluri-disciplinaire. Son implantation est principalement sur la ville de Reims mais elle dispose aussi d'antennes à Châlons-en-Champagne, à Troyes, Chaumont et à Charleville-Mézières.")
		Comunity.create(:name => "ENSIETA", :address => "Brest, France", :keywords => "Lille", :description => "L'ENSIETA est une école nationale supérieure d'ingénieurs à vocation pluridisciplinaire formant à Brest des ingénieurs civils et militaires capables d'assurer, dans un environnement international, la conception et la réalisation de systèmes industriels complexes à dominante électronique, informatique, mécanique ou pyrotechnique.")
  end

  def self.down
		Comunity.delete_all
  end
end
