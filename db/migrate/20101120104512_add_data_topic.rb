class AddDataTopic < ActiveRecord::Migration
  def self.up
  	Topic.delete_all
  	Topic.create(:title => 'Comment marche la recherche ?', :forum_id => 1, :user_id => 2, :description => 'Bonjour, Je n\'arrive pas a trouver un trajet qui m\interesse...' )
  	Topic.create(:title => 'Problème d\'inscription', :forum_id => 2, :user_id => 2, :description => 'Bonjour, mon ami n\'arrive pas s\'inscrire, pouvez vous l\'aider?' )
  	Topic.create(:title => 'Information - Tri des déchets', :forum_id => 3, :user_id => 2, :description => 'Vous voulez savoir comment calculer l\'emprunte carbone ? Et bien moi aussi !' )

  end

  def self.down
   	Topic.delete_all
  end
end
