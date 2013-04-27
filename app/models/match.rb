class Match < ActiveRecord::Base
  has_many :moves

  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'
  belongs_to :championship

  delegate :name, to: :championship, prefix: true
  delegate :name, :badge_url, to: :home_team, prefix: true
  delegate :name, :badge_url, to: :away_team, prefix: true

  attr_accessible :home_team, :away_team, :home_team_score,
                  :away_team_score, :championship
end
