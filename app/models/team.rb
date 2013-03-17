class Team < ActiveRecord::Base
  mount_uploader :badge, BadgeUploader

  has_many :home_matches, class_name: "Match", foreign_key: "home_team_id"
  has_many :away_matches, class_name: "Match", foreign_key: "away_team_id"
  has_many :news

  def matches
    my_id = self.id
    Match.where("home_team_id = ? OR away_team_id = ?", my_id, my_id)
  end

  def current_match
    matches.last
  end
end
