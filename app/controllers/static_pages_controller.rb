class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:rules]
  
  # Home page when a user is logged in.
  def home
    # leagues with pending request
    @pending_leagues  = League.with_pending_requests(current_user)
    # leagues joined
    @joined_leagues   = League.for_user(current_user)
    # leagues that the user can send a request to join (which means the user hasn't sent a request yet)
    @possible_leagues = League.can_send_request(current_user)

    @request = Request.new
  end

  def rules
  end
  
end
