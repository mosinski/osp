class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :nazwa
      t.string :stanowisko

      t.timestamps
    end
  end
end
