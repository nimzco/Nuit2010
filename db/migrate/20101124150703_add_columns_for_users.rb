class AddColumnsForUsers < ActiveRecord::Migration
  def self.up
		add_column :users, :type, :string
		add_column :users, :address, :string
		add_column :users, :phone_number, :string
		add_column :users, :company_id, :integer
  end

  def self.down
		remove_column :users, :type, :address, :phone_number, :company_id
  end
end
