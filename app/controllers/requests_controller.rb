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
    @request.accepted_at = Time.now

    respond_to do |format|
      if @request.update(request_params)
        if Request.statuses[@request.status] == Request.statuses[:accepted]
          # let's create a member
          member = Member.new(:user_id => @request.user_id, :league_id =>  @request.league_id, :occupation => :player, :username => current_user.username)
          member.save

          # and create a ranking for each tournament of the league
          league = League.find(@request.league_id)
          league.tournaments.each do |tournament|
            ranking = Ranking.create(:member_id => member.id, :league_id =>  @request.league_id, :tournament_id => tournament.id)
          end
        end
        format.html { redirect_to @request.league, notice: 'Request was successfully updated.' }
      else
        format.html { redirect_to @request.league, notice: 'Problem while updating request.' }
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
    params.require(:request).permit(:league_id, :status)
  end
end