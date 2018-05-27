class GuessesController < ApplicationController
  before_action :set_guess, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /guesses
  # GET /guesses.json
  def index
    @guesses = Guess.all
  end

  # GET /guesses/1
  # GET /guesses/1.json
  def show
  end

  # GET /guesses/new
  def new
    @guess = Guess.new
  end

  # GET /guesses/1/edit
  def edit
  end

  # POST /guesses
  # POST /guesses.json
  def create
    faction_id = params[:guess][:faction_id]
    member_id = Member.where(:faction_id => faction_id).where(:user_id => current_user.id).pluck(:id).first
    if member_id == nil
      render json: {msg: "ko"}, status: :unprocessable_entity
      return
    end

    game = Game.find_by_id(params[:guess][:game_id])
    if game.kickoff_at < DateTime.now
      render json: {msg: "ko"}, status: :unprocessable_entity
      return
    end

    result = params[:guess][:result]

    # check if there is already a guess
    guess = Guess.find_or_create_by(faction_id: faction_id, member_id: member_id, game_id: game.id)
    guess.result = result


    if guess.save
      render json: {msg: "ok"}, status: :ok
    else
      # todo msg could contain the error message
      render json: {msg: "ko"}, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /guesses/1
  # PATCH/PUT /guesses/1.json
  def update
    respond_to do |format|
      if @guess.update(guess_params)
        format.html { redirect_to @guess, notice: 'Guess was successfully updated.' }
        format.json { render :show, status: :ok, location: @guess }
      else
        format.html { render :edit }
        format.json { render json: @guess.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guesses/1
  # DELETE /guesses/1.json
  def destroy
    @guess.destroy
    respond_to do |format|
      format.html { redirect_to guesses_url, notice: 'Guess was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guess
      @guess = Guess.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guess_params
      params.require(:guess).permit(:member_id, :game_id, :faction_id, :result)
    end
end
