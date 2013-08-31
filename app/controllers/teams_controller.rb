# encoding: utf-8
class TeamsController < ApplicationController
  def show
    @team = Team.find(params[:id])
    @match = @team.current_match
    @matches = @team.matches.includes(:home_team, :away_team)
    @news = @team.news.limit(20)
    @trusted_domains = TrustedDomain.pluck(:name)
    @photos = @team.photos.limit(20)
    @help = "Você está em: Página do Time

  Já que amor por time não se mede, reunimos os dados recolhidos dos jogos que seu time participou em forma de gráfico, mapa, notícias e fotos.
  E se bater aquela saudade de um jogaço que seu time participou, é só dar uma olhadinha na lista de últimos jogos.
"
  end
end
