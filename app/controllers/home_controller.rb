# encoding: utf-8
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
    @matches.uniq!.sort_by! { |e| e[:start_time] }
    @help = "Bem-vindo(a) ao portal Futwitter ! Nós temos como objetivo principal reunir informações do Twitter e de outros lugares da internet de maneiras diversas.

Você está em: Página Inicial

Nesta página é possível filtrar os jogos e times que aparecem por campeonatos. Além disso, basta clicar em algum jogo ou time de interesse para ser redirecionado para sua página no Futwitter."
  end
end
