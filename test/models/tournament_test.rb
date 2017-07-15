require 'test_helper'


class TournamentTest < ActiveSupport::TestCase

  def setup
    @tournament = tournaments(:tournament1)
  end

  test "should be valid" do
    assert @tournament.valid?
  end

  test "name should be present" do
    @tournament.name = nil
    assert_not @tournament.valid?
  end

  test "location should be present" do
    @tournament.location = nil
    assert_not @tournament.valid?
  end

  test "year should be present" do
    @tournament.year = nil
    assert_not @tournament.valid?
  end

  test "name should not be too long" do
    @tournament.name = "a" * 21
    assert_not @tournament.valid?
  end

  test "location should not be too long" do
    @tournament.location = "a" * 21
    assert_not @tournament.valid?
  end

  test "year should be 4 char long" do
    @tournament.year = "a" * 5
    assert_not @tournament.valid?

    @tournament.year = "a" * 3
    assert_not @tournament.valid?
  end

  test "year should not be negative" do
    @tournament.year = -201
    assert_not @tournament.valid?

    @tournament.year = -2018
    assert_not @tournament.valid?
  end

end