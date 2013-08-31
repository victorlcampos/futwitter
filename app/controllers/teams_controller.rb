# encoding: utf-8
class TeamsController < ApplicationController
  def show
    @team = Team.find(params[:id])
    @match = @team.current_match
    @matches = @team.matches.includes(:home_team, :away_team)
    @news = @team.news.limit(20)
    @trusted_domains = TrustedDomain.pluck(:name)
    @photos = @team.photos.limit(20)
    @help = "Não achei os textos 3"
  end
end
