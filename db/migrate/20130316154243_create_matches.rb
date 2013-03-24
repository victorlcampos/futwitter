class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.references :home_team
      t.references :away_team
      t.integer :home_team_score
      t.integer :away_team_score

      t.timestamps
    end
    add_index :matches, :home_team_id
    add_index :matches, :away_team_id
    add_index :matches, [:home_team_id, :away_team_id]
  end
end
