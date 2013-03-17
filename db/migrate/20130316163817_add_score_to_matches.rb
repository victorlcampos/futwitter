class AddScoreToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :home_team_score, :integer
    add_column :matches, :away_team_score, :integer
  end
end
