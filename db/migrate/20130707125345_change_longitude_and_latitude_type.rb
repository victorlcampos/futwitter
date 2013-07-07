class ChangeLongitudeAndLatitudeType < ActiveRecord::Migration
  def up
    change_column :tweets, :longitude, :float
    change_column :tweets, :latitude, :float
  end

  def down
    change_column :tweets, :longitude, :integer
    change_column :tweets, :latitude, :integer
  end
end
