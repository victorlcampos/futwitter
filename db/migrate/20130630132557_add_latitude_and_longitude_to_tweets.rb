class AddLatitudeAndLongitudeToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :latitude, :integer
    add_column :tweets, :longitude, :integer
  end
end
