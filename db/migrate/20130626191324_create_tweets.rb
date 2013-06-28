class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.references :team
      t.string :text
      t.string :geo

      t.timestamps
    end
    add_index :tweets, :team_id
  end
end
