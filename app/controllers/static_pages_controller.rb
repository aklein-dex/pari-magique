class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:rules]

  # Home page when a user is logged in.
  def home
    # factions with pending request
    @pending_factions  = Faction.with_pending_requests(current_user)

    # factions that the user can send a request to join (which means the user hasn't sent a request yet)
    @possible_factions = Faction.can_send_request(current_user)

    @request = Request.new
  end

  def rules
  end

end
