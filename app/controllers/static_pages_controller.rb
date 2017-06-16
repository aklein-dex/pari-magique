class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:home]

  # Controller for the home page that contains only the sign in/sign up button
  def home_root
    if user_signed_in?
      redirect_to static_pages_home_url
    end
  end

  # Home page when a user logs in.
  def home
    @all_leagues = League.all.order(:name)
  end

  def rules
  end
end
