class TeamsController < ApplicationController
  def show
    @team = Team.find(params[:id])
    @match = @team.current_match
    @news = @team.news.limit(20)
    @trusted_domains = TrustedDomain.pluck(:name)
  end
end
