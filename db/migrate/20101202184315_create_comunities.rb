class CreateComunities < ActiveRecord::Migration
  def self.up
    create_table :comunities do |t|
      t.string :name
      t.string :address
      t.string :keywords
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :comunities
  end
end
