class MatchesController < ApplicationController
  def show
    match = Match.find(params[:id])
    UpdateMovesService.new(match).update_moves_from_internet
    @presenter = MatchesShowPresenter.new(match)
  end
end
