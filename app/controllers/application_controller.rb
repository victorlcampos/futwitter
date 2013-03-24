class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_teams

  protected
  def load_teams
    @teams = Team.all
  end
end
