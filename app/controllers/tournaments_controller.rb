class TournamentsController < ApplicationController
  before_action :set_tournament_and_faction, only: [:show, :group, :round, :guesses, :ranking]
  load_and_authorize_resource

  # Main page to show an overview of the tournament
  def show
    @coming_games = @tournament.games.select("games.*, guesses.result as guess_result, guesses.id as guess_id").includes(:home, :away, :stadium).next_5_games.joins("LEFT JOIN guesses ON games.id = guesses.game_id and guesses.member_id = #{current_user.member_id_for_faction(@faction.id)} and guesses.faction_id = #{@faction.id}")
    @last_games   = @tournament.games.select("games.*, guesses.result as guess_result, guesses.id as guess_id").includes(:home, :away, :stadium).last_5_games.joins("LEFT JOIN guesses ON games.id = guesses.game_id and guesses.member_id = #{current_user.member_id_for_faction(@faction.id)} and guesses.faction_id = #{@faction.id}")
    @guess        = Guess.new(:faction => @faction)
    @rankings     = Ranking.where(:faction_id => @faction.id, :tournament_id => @tournament.id)
  end

  # Show the games for a specific group
  def group
    @games = @tournament.games.select("games.*, guesses.result as guess_result, guesses.id as guess_id").includes(:home, :away, :stadium).joins("LEFT JOIN guesses ON games.id = guesses.game_id and guesses.member_id = #{current_user.member_id_for_faction(@faction.id)} and guesses.faction_id = #{@faction.id}").where(group: params[:group_id]).order(:kickoff_at)
    @guess = Guess.new(:faction => @faction)
  end

  # Show the games for a specific round
  def round
    @games = @tournament.games.select("games.*, guesses.result as guess_result, guesses.id as guess_id").includes(:home, :away, :stadium).joins("LEFT JOIN guesses ON games.id = guesses.game_id and guesses.member_id = #{current_user.member_id_for_faction(@faction.id)} and guesses.faction_id = #{@faction.id}").where(round: params[:round_id]).order(:kickoff_at)
    @guess = Guess.new(:faction => @faction)
  end

  # Show the guesses of everyone (only for past games)
  def guesses
    # Get all the past games
    games = @tournament.games.includes(:home, :away, :stadium).past_games

    # Get the guesses
    guesses =  Guess.where(:faction_id => @faction.id, :game_id => games).pluck(:member_id, :game_id, :result)
    # hash the guesses to find stuff faster
    hashed_guesses = {}
    guesses.each do |guess|
      if not hashed_guesses.has_key?(guess[0])
        hashed_guesses[guess[0]] = {}
      end

      hashed_guesses[guess[0]][guess[1]] = guess[2]
    end


    members = Member.where(:faction_id => @faction.id)

    # This will contain the the rows and columns displayed in the view
    @table = [[]]

    # The first row is the usernames
    @table[0] << ""
    @table[0] << "Result"
    members.each do |member|
      @table[0] << member.username
    end

    row = 1
    games.each do |game|
      @table << []
      #@table[row] << "#{game.home.name} vs #{game.away.name}"
      @table[row] << game
      @table[row] << game.result
      members.each do |member|
        if hashed_guesses.has_key?(member.id) and hashed_guesses[member.id].has_key?(game.id)
          @table[row] << hashed_guesses[member.id][game.id]
        else
          @table[row] << "-"
        end
      end
      row+=1
    end
  end

  def ranking
    # todo
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_tournament_and_faction

    # if you look at the routes for "group", you will see that it is tournament_id,
    # but the routes for "show", it is just "id".
    tournament_id = params[:id] ? params[:id] : params[:tournament_id]

    @tournament = Tournament.find(tournament_id)
    @faction    = Faction.find(params[:faction_id])
  end
end
