class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:home_root, :rules]

  # Controller for the home page that contains only the sign in/sign up button
  def home_root
    if user_signed_in?
      redirect_to static_pages_home_url
    end
  end

  # Home page when a user is logged in.
  def home
    @all_leagues = League.all.order(:name)
    @request = Request.new
  end

  def rules
  end
end
