class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.references :match
      t.integer :minute
      t.string :team_name
      t.text :text
      t.timestamps
    end
    add_index :moves, :match_id
  end
end
