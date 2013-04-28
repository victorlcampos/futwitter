module TeamsHelper
  def team_classes(team)
    championships_ids = team.championships_ids
    "championship_#{championships_ids.join(' championship_')}"
  end
end
