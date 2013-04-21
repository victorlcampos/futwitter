class HomeController < ApplicationController
  skip_before_filter :load_teams, :load_championchip

  def index
    Match.update_matches_from_internet
    @matches = Match.includes(:home_team, :away_team).all
    @teams = Team.all
    @championships = Championship.all
  end
end
