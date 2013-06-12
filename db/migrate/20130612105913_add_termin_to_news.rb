class AddTerminToNews < ActiveRecord::Migration
  def change
    add_column :news, :termin, :date
    News.update_all 'termin = created_at'
  end
end
