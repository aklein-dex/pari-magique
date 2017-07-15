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
end