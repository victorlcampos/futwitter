class MatchesController < ApplicationController
  def show
    @match = Match.find(params[:id])
    @moves = @match.moves
  end
end
