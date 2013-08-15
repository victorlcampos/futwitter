class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :match
      t.references :team
      t.string :url
      t.string :description
      t.timestamps
    end
  end
end
