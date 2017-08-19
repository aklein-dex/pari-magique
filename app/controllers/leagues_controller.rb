class LeaguesController < ApplicationController
  before_action :set_league, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource


  # GET /leagues/1
  # GET /leagues/1.json
  def show
  end

  # GET /leagues/new
  def new
    @league = League.new
  end

  # GET /leagues/1/edit
  def edit
  end

  # POST /leagues
  def create
    @league = League.new(league_params)

    begin
      League.transaction do
        @league.save!
        member = Member.new(:user_id => current_user.id, :league_id =>  @league.id, :occupation => :coach, :username => current_user.username)
        member.save!

        redirect_to @league, notice: 'League was successfully created.'
        return
      end
    rescue ActiveRecord::RecordInvalid => error
      status = :internal_server_error
    rescue ActiveModel::UnknownAttributeError => error
      status = :bad_request
    end

    render :new, :status => status
  end

  # PATCH/PUT /leagues/1
  def update
    begin
      League.transaction do
        @league.update(league_params)

        # Did we add a tournament? If yes, then we have to create a ranking for all the members
        if(params[:league][:tournament_ids])
          @league.members.each do |member|
            Ranking.create(:member_id => member.id, :tournament_id => params[:league][:tournament_ids], :league_id => @league.id)
          end
        end

        redirect_to @league, notice: 'League was successfully updated.'
        return
      end
    rescue ActiveRecord::RecordInvalid => error
      status = :internal_server_error
    rescue ActiveModel::UnknownAttributeError => error
      status = :bad_request
    end

    render :edit, :status => status
  end

  # DELETE /leagues/1
  # DELETE /leagues/1.json
  def destroy
    @league.destroy
    respond_to do |format|
      format.html { redirect_to leagues_url, notice: 'League was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_league
      @league = League.find_by(id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def league_params
      #params.require(:league).permit(:name, :tournament_ids)
      params.fetch(:league, {}).permit(:name, :tournament_ids)
    end
end
