class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :tytul
      t.integer :nr_newsa

      t.timestamps
    end
  end
end
