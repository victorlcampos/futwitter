class AddStartTimeToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :start_time, :datetime
  end
end
