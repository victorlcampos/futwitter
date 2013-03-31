class HomeController < ApplicationController
  def index
    Match.update_matches_from_internet
    @matches = Match.all
  end
end
