class CreatePliks < ActiveRecord::Migration
  def change
    create_table :pliks do |t|
      t.string :nazwa
      t.text :opis

      t.timestamps
    end
  end
end
