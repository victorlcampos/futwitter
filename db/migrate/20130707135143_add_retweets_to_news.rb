class AddRetweetsToNews < ActiveRecord::Migration
  def change
    add_column :news, :retweets, :integer
  end
end
