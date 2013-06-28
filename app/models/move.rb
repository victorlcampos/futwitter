class Move < ActiveRecord::Base
  default_scope order('half Desc, minute Desc')

  belongs_to :match
  attr_accessible :match_id, :minute, :text, :team_name, :half

  def team_name=(team_name)
    write_attribute(:team_name, team_name.downcase) if team_name
  end

  def team_name
    my_team_name = read_attribute(:team_name)
    my_team_name.humanize if my_team_name
  end
end
