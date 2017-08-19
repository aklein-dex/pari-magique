require 'test_helper'

class ManageLeagueTest < ActionDispatch::IntegrationTest

  test "should display the league the user belong to" do
    user = users(:user1)
    sign_in user

    get static_pages_home_url
    assert_response :success

    get new_league_url
    assert_response :success

    league_name = "TestLeague"
    assert_difference 'League.count', 1 do
      post leagues_path, params: { league: { name: league_name } }
    end

    get static_pages_home_url
    assert_select "#joined_leagues a", league_name
  end

  test "should see requests (still pending) for leagues" do
    user = users(:user1)
    league3 = leagues(:league3)
    league5 = leagues(:league5)

    sign_in user

    get static_pages_home_url
    assert_response :success
    assert_select "#pending_leagues a", league3.name
    assert_select "#pending_leagues a", league5.name
  end

  test "should see leagues that the user can join" do
    user = users(:user1)
    league6 = leagues(:league6)

    sign_in user

    get static_pages_home_url
    assert_response :success
    assert_select "#possible_leagues a", league6.name
  end
end
