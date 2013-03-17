class AddBadgeToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :badge, :string
  end
end
