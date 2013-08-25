class AddMoodToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :mood, :integer, default: 0
  end
end
