class ChangeGeoTypeInTweet < ActiveRecord::Migration
  def up
    remove_column :tweets, :geo
    add_column :tweets, :geo, :boolean, default: false
  end

  def down
    remove_column :tweets, :geo
    add_column :tweets, :geo, :string
  end
end
