class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :nazwa
      t.text :opis
      t.string :przydzial

      t.timestamps
    end
  end
end
