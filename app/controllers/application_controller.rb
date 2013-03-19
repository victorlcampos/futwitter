class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_team

  protected
  def load_team
    @teams = Team.all
  end
end
