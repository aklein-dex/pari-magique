require 'test_helper'


class GuessTest < ActiveSupport::TestCase

  def setup
    @guess = guesses(:guess1)
  end

  test "should be valid" do
    assert @guess.valid?
  end

  test "member should be present" do
    @guess.member_id = nil
    assert_not @guess.valid?
  end

  test "game should be present" do
    @guess.game_id = nil
    assert_not @guess.valid?
  end

  test "league should be present" do
    @guess.league_id = nil
    assert_not @guess.valid?
  end

  test "result should be valid" do
    @guess.result = "2-2"
    assert @guess.valid?

    @guess.result =  "abc"
    assert_not @guess.valid?

    @guess.result =  "2.2"
    assert_not @guess.valid?

    @guess.result =  "2"
    assert_not @guess.valid?

    @guess.result =  "2-"
    assert_not @guess.valid?

    @guess.result =  "-0"
    assert_not @guess.valid?
  end

end