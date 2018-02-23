class Manager::GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # receive a csv file containing a list of games
  def import
    if params[:file]
      Game.import(params[:file], params[:tournament_id])
      redirect_to manager_games_url, notice: 'Games were successfully imported.'
    else
      redirect_to manager_games_url, alert: 'No file specified.'
    end
  end
  
  # GET /games
  # GET /games.json
  def index
    @games = Game.all.includes(:home, :away, :stadium, :tournament)
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
      if @game.update(game_params) # this triggers after_update callback
        format.html { redirect_to [:manager, @game], notice: 'Game was successfully updated.' }
        format.json { render json: {msg: "ok"}, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: {msg: "ko"}, status: :unprocessable_entity }
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
      params.require(:game).permit(:tournament_id, :home_id, :away_id, :result, :kickoff_at, :stage, :group, :round, :stadium_id)
    end
end
