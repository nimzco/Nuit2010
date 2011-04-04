class AddData < ActiveRecord::Migration
  def self.up
	Forum.delete_all
	Forum.create(:id => 1, :name => 'Fonctionnement g&eacute;n&eacute;ral', :description => 'Un forum ou vous pouvez posez toutes vos questions concernant le site et le covoiturage !', :user_id => 1)
	Forum.create(:id => 2, :name => 'Probl&egrave;mes en tout genre', :description => 'Un forum ou vous pouvez posez toutes vos questions concernant les probl&egrave;mes que vous avez eu avec le covoiturage.', :user_id => 1)
	Forum.create(:id => 3, :name => 'Environnement', :description => 'Vous &ecirc;tes soucieux de l\'environnement ? Et bien nous aussi !', :user_id => 1)
  end

  def self.down
	Forum.delete_all
  end
end
