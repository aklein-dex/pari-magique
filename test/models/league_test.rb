require 'test_helper'


class LeagueTest < ActiveSupport::TestCase

  def setup
    @league = leagues(:league1)
  end

  test "should be valid" do
    assert @league.valid?
  end

  test "name should be present" do
    @league.name = nil
    assert_not @league.valid?
  end

  test "name should not be too long" do
    @league.name = "a" * 21
    assert_not @league.valid?
  end

  test "should get 1 league for user1" do
    user = users(:user1)
    leagues = League.for_user(user)
    assert_equal(1, leagues.count)
    assert_equal("My League", leagues[0].name)
  end

  test "should get 2 leagues for user2" do
    user2 = users(:user2)
    leagues = League.for_user(user2)
    assert_equal(2, leagues.count)
    assert_equal("My League", leagues[0].name)
    assert_equal("2nd League", leagues[1].name)
  end

  test "should get 2 leagues with pending request for user1" do
    user = users(:user1)
    leagues = League.with_pending_requests(user)
    assert_equal(2, leagues.count)
  end

  test "should get 0 league with pending request for user2" do
    user = users(:user2)
    leagues = League.with_pending_requests(user)
    assert_equal(0, leagues.count)
  end

  test "user1 can send request to 2 leagues" do
    # should not count league where user is coach!!!!!!!!!
    user = users(:user1)
    leagues = League.can_send_request(user)
    assert_equal(2, leagues.count)
  end

  test "user2 can send request to 4 leagues" do
    # should not count league where user is coach!!!!!!!!!
    user = users(:user2)
    leagues = League.can_send_request(user)
    assert_equal(4, leagues.count)
  end
end