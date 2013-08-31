# encoding: utf-8
class MatchesController < ApplicationController
  def show
    match = Match.find(params[:id])
    UpdateMovesService.new(match).update_moves_from_internet
    @presenter = MatchesShowPresenter.new(match)
    @help = "Você está em: Página do Jogo

Aqui você encontrará o fotos, placar e o lance a lance daquele jogo que você escolheu acompanhar. E como sabemos que torcidas gostam de participar, exibimos alguns dados numéricos, um gráfico e um mapa, tudo para facilitar na hora de comparar qual time está “vencendo” na internet.
E porque não ver qual se seus amigos torcedores estão felizes ou não com o desempenho do time no jogo?
"
  end
end
