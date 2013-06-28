class AddMinuteToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :minute, :integer
  end
end
