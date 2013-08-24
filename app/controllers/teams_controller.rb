class TeamsController < ApplicationController
  def show
    @team = Team.find(params[:id])
    @match = @team.current_match
    @matches = @team.matches
    @news = @team.news.limit(20)
    @trusted_domains = TrustedDomain.pluck(:name)
    @photos = @team.photos.limit(20)
  end
end
