class RequestsController < ApplicationController
  before_action :set_request, only: [:update]
  load_and_authorize_resource

  def create
    @request = Request.new(request_params)
    @request.user_id = current_user.id
    @request.status  = Request.statuses[:pending]

    respond_to do |format|
      if @request.save
        format.html { redirect_to root_path, notice: 'Request was successfully created.' }
      else
        format.html { redirect_to root_path, notice: 'Problem with request.' }
      end
    end
  end

  def update
    # TODO: check if the current_user is a coach and can modify the faction
    @request.accepted_at = Time.now

    respond_to do |format|
      if @request.update(request_params)
        if Request.statuses[@request.status] == Request.statuses[:accepted]
          # let's create a member
          username = User.where(id: @request.user_id).pluck(:username).first
          member = Member.new(:user_id => @request.user_id, :faction_id =>  @request.faction_id, :occupation => :player, :username => username)
          member.save

          # and create a ranking for each tournament of the faction
          faction = Faction.find(@request.faction_id)
          faction.tournaments.each do |tournament|
            ranking = Ranking.create(:member_id => member.id, :faction_id =>  @request.faction_id, :tournament_id => tournament.id)

            # TODO if there are already games played, then we should increase the value of "point0"
          end
        end
        format.html { redirect_to @request.faction, notice: 'Request was successfully updated.' }
      else
        format.html { redirect_to @request.faction, notice: 'Problem while updating request.' }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_request
    @request = Request.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def request_params
    params.require(:request).permit(:faction_id, :status)
  end
end
