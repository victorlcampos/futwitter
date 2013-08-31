# encoding: utf-8
class MatchesController < ApplicationController
  def show
    match = Match.find(params[:id])
    UpdateMovesService.new(match).update_moves_from_internet
    @presenter = MatchesShowPresenter.new(match)
    @help = "Não achei os textos 2"
  end
end
