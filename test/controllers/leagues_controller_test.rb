require 'test_helper'

class LeaguesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:user1)
  end

  #################### CREATE ####################
  test "should create league" do
    sign_in @user
    assert_difference('League.count') do
      post leagues_url, params: { league: { "name": "test league" }}
    end
    assert_redirected_to league_path(League.last)
  end

  test "should not create league if not logged in" do
    assert_no_changes('League.count') do
      post leagues_url, params: { league: { "name": "test league" }}
    end
    assert_redirected_to new_user_session_url
  end

  test "should not create league with nil params" do
    sign_in @user
    assert_no_difference('League.count') do
      post leagues_url, params: nil
    end
    assert_response :internal_server_error
  end

  test "should not create league with strange params" do
    sign_in @user
    assert_no_difference('League.count') do
      post leagues_url, params: { league: { "nop": "nop" }}
    end
    assert_response :internal_server_error
  end

  #################### GET ####################
  test "should show league for a coach" do
    sign_in @user
    league = leagues(:league1)
    get league_url(league)
    assert_response :success
  end

  test "should show league for a player" do
    player = users(:user2)
    sign_in player
    league = leagues(:league1)
    get league_url(league)
    assert_response :success
  end

  test "should not show league for non-member" do
    sign_in @user
    league = leagues(:league2)
    get league_url(league)
    assert_redirected_to root_url
  end

  #################### UPDATE ####################

  test "should update league" do
    sign_in @user
    league = leagues(:league1)
    patch league_url(league), params: { league: {"name": "newleaguename123"}}
    assert_redirected_to league
  end

  test "should not update league because not coach" do
    player = users(:user2)
    sign_in player
    league = leagues(:league1)
    patch league_url(league), params: { league: {"name": "newleaguename123"}}
    assert_redirected_to root_url
  end

end