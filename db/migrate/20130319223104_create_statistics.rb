class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.integer :rok
      t.integer :pozary
      t.integer :zagrozenia
      t.integer :falarmy

      t.timestamps
    end
  end
end
