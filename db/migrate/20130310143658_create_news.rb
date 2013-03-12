class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :tytul
      t.text :tresc

      t.timestamps
    end
  end
end
