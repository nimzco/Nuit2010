class BugfixCompany < ActiveRecord::Migration
  def self.up
	  
# 	remove_column :company_id
	add_column :users, :comunity_id, :integer
  end

  def self.down
	  
		remove_column :comunity_id
# 		add_column :users, :company_id, :integer
  end
end
