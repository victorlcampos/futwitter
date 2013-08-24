class HomeController < ApplicationController
  skip_before_filter :load_teams, :load_championchip

  def index
    UpdateMatchService.new.update_matches_from_internet

    @teams = Team.order('name').all

    @matches = []
    @championships = Championship.order_by_matches_count
    @teams.each do |team|
      @matches << team.current_match
    end
    @matches.uniq!.sort_by!{|e| e[:start_time]}
  end
end
