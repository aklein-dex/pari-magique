require 'test_helper'


class RankingTest < ActiveSupport::TestCase

  def setup
    @ranking = rankings(:ranking1)
  end

  test "should be valid" do
    assert @ranking.valid?
  end

  test "member should be present" do
    @ranking.member_id = nil
    assert_not @ranking.valid?
  end

  test "league should be present" do
    @ranking.league_id = nil
    assert_not @ranking.valid?
  end

  test "tournament should be present" do
    @ranking.tournament_id = nil
    assert_not @ranking.valid?
  end

  test "point3 should be greather than or equal to 0" do
    @ranking.point3 = -1
    assert_not @ranking.valid?
  end

  test "point1 should be greather than or equal to 0" do
    @ranking.point1 = -1
    assert_not @ranking.valid?
  end

  test "point0 should be greather than or equal to 0" do
    @ranking.point0 = -1
    assert_not @ranking.valid?
  end


end