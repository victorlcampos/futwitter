class AddChampionshipIdToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :championship_id, :integer
    add_index :matches, :championship_id
  end
end
