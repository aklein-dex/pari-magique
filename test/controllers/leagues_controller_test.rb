require 'test_helper'

class LeaguesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:user1)
  end

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

end