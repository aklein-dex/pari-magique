class Manager::GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to [:manager, @game], notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update

    respond_to do |format|
      if @game.update(game_params)

        # TODO: what happen if we edit a result? -> have to recalculate all the rankings for the tournament in all the leagues!

        if @game.result != nil
          # Update the rankings
          guesses = Guess.where(:game_id => @game.id)
          guesses.each do |guess|
            ranking = Ranking.where(:member_id => guess.member_id, :tournament_id => @game.tournament_id, :league_id => guess.league_id).first

            if guess.is_perfect_guess?(@game.result)
              ranking.point3 = ranking.point3 + 1;
              # could use:
              #   Ranking.where(:member_id => guess.member_id, :tournament_id => @game.tournament_id, :league_id => guess.league_id).first.increment!(:point3)
            elsif guess.is_good_guess?(@game.result)
              ranking.point1 = ranking.point1 + 1;
            else
              ranking.point0 = ranking.point0 + 1;
            end
            ranking.save
          end
        end

        format.html { redirect_to [:manager, @game], notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to manager_games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:tournament_id, :home_id, :away_id, :result, :kickoff_at, :stage, :pool, :stadium_id)
    end
end
