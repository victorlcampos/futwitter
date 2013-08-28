class AddIntexToPhotos < ActiveRecord::Migration
  def change
    add_index :photos, :team_id
    add_index :photos, :match_id
  end
end
