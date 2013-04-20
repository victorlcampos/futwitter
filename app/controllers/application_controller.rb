class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_teams
  before_filter :load_championchip

  protected
  def load_championchip
    @championships= Championship.all
  end

  def load_teams
    @teams = Team.all
  end
end
