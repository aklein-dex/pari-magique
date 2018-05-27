class Admin::FactionsController < ApplicationController
  before_action :set_faction, only: [:destroy]
  load_and_authorize_resource


  # GET /factions/1
  # GET /factions/1.json
  def index
    @factions = Faction.all
  end

  # DELETE /factions/1
  # DELETE /factions/1.json
  def destroy
    @faction.destroy
    respond_to do |format|
      format.html { redirect_to admin_factions_url, notice: 'faction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_faction
      @faction = Faction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def faction_params
      params.require(:faction).permit(:name, :tournament_ids)
    end
end
