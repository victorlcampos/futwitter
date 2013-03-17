class Match < ActiveRecord::Base
  belongs_to :home_team, class_name: "Team"
  belongs_to :away_team, class_name: "Team"

  delegate :name, to: :home_team, prefix: true
  delegate :badge_url, to: :home_team, prefix: true
  delegate :name, to: :away_team, prefix: true
  delegate :badge_url, to: :away_team, prefix: true
end
