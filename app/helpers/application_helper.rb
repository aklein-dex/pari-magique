module ApplicationHelper
  def joined_leagues
    @joined_leagues = League.for_user(current_user)
  end
end
