class Admin::LeaguesController < ApplicationController
  before_action :set_league, only: [:destroy]
  load_and_authorize_resource
  

  # GET /leagues/1
  # GET /leagues/1.json
  def index
    @leagues = League.all
  end

  # DELETE /leagues/1
  # DELETE /leagues/1.json
  def destroy
    @league.destroy
    respond_to do |format|
      format.html { redirect_to admin_leagues_url, notice: 'League was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_league
      @league = League.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def league_params
      params.require(:league).permit(:name, :tournament_ids)
    end
end
