class HomeController < ApplicationController
  def index
    @teams = Team.all
    @matches = Match.all
  end
end
