class FactionsController < ApplicationController
  before_action :set_faction, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /factions
  # GET /factions.json
  def index
    # factions with pending request
    @pending_factions  = Faction.with_pending_requests(current_user)
    # factions that the user can send a request to join (which means the user hasn't sent a request yet)
    @possible_factions = Faction.can_send_request(current_user)
    @request  = Request.new
  end

  # GET /factions/1
  # GET /factions/1.json
  def show
    @chat_room = ChatRoom.includes(:messages).find_by(faction_id: @faction.id)
    @message   = Message.new
    
    @tournaments = @faction.tournaments
    @can_join_tournaments = Tournament.where.not(id: @tournaments.map(&:id))
  end

  # GET /factions/new
  def new
    @faction = Faction.new
  end

  # GET /factions/1/edit
  def edit
  end

  # POST /factions
  def create
    @faction = Faction.new(faction_params)

    begin
      Faction.transaction do
        @faction.save!
        member = Member.new(:user_id => current_user.id, :faction_id => @faction.id, :occupation => :coach, :username => current_user.username)
        member.save!

        chat_room = ChatRoom.new(:faction_id => @faction.id, :title => @faction.name)
        chat_room.save!

        redirect_to @faction, notice: 'faction was successfully created.'
        return
      end
    rescue ActiveRecord::RecordInvalid => error
      status = :internal_server_error
    rescue ActiveModel::UnknownAttributeError => error
      status = :bad_request
    end

    render :new, :status => status
  end

  # PATCH/PUT /factions/1
  def update
    begin
      Faction.transaction do
        @faction.update(faction_params)

        # Did we add a tournament? If yes, then we have to create a ranking for all the members
        if(params[:faction][:tournament_ids])
          @faction.members.each do |member|
            Ranking.create(:member_id => member.id, :tournament_id => params[:faction][:tournament_ids], :faction_id => @faction.id)
          end
        end

        redirect_to @faction, notice: 'faction was successfully updated.'
        return
      end
    rescue ActiveRecord::RecordInvalid => error
      status = :internal_server_error
    rescue ActiveModel::UnknownAttributeError => error
      status = :bad_request
    end

    render :edit, :status => status
  end

  # DELETE /factions/1
  # DELETE /factions/1.json
  def destroy
    @faction.destroy
    respond_to do |format|
      format.html { redirect_to factions_url, notice: 'faction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_faction
      @faction = Faction.find_by(id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def faction_params
      #params.require(:faction).permit(:name, :tournament_ids)
      params.fetch(:faction, {}).permit(:name, :tournament_ids)
    end
end
