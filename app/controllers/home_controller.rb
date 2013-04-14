class HomeController < ApplicationController
  def index
    Match.update_matches_from_internet
    @matches = Match.includes(:home_team, :away_team).all
  end
end
