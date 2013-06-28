class AddTweetsCountToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :tweets_count, :integer, default: 0
  end
end
