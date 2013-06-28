class MatchesController < ApplicationController
  def show
    @match = Match.find(params[:id])
    UpdateMovesService.new(@match).update_moves_from_internet
    @moves = @match.moves
    @home_tweets_per_minute = @match.home_tweets_per_minute
    @away_tweets_per_minute = @match.away_tweets_per_minute
  end
end
