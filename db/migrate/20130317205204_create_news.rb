class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.references :team
      t.string  :image
      t.string :title
      t.string :url
      t.text :description
      t.timestamps
    end
    add_index :news, :team_id
  end
end
