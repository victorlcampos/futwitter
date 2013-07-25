class HomeController < ApplicationController
  skip_before_filter :load_teams, :load_championchip

  def index
    UpdateMatchService.new.update_matches_from_internet

    @matches = Match.includes(:home_team, :away_team).order('start_time').all
    @teams = Team.order('name').all
    @championships = Championship.order_by_matches_count
  end
end
