class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :nazwa
      t.text :opis
      t.string :przydzial

      t.timestamps
    end
  end
end
