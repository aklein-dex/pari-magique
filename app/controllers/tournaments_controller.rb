class TournamentsController < ApplicationController
  before_action :set_tournament_and_league, only: [:show]
  load_and_authorize_resource


  def show
    @coming_games = @tournament.games.next_5_games
    @last_games   = @tournament.games.last_5_games
    @guess        = Guess.new(:league => @league)
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_tournament_and_league
    @tournament = Tournament.find(params[:id])
    @league     = League.find(params[:league_id])
  end
end
