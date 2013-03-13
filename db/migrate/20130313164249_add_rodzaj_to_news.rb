class AddRodzajToNews < ActiveRecord::Migration
  def self.up
    add_column :news, :rodzaj, :string
  end
 
  def self.down
    remove_column :news, :rodzaj
  end
end
