require 'test_helper'


class GameTest < ActiveSupport::TestCase

  def setup
    @game = games(:game1)
  end

  test "should be valid" do
    assert @game.valid?
  end

  test "should be valid without a result" do
    @game.result = nil
    assert @game.valid?
  end

  test "tournament should be present" do
    @game.tournament_id = nil
    assert_not @game.valid?
  end

  test "result should be valid" do
    @game.result = "2-2"
    assert @game.valid?

    @game.result =  "abc"
    assert_not @game.valid?

    @game.result =  "2.2"
    assert_not @game.valid?

    @game.result =  "2"
    assert_not @game.valid?

    @game.result =  "2-"
    assert_not @game.valid?

    @game.result =  "-0"
    assert_not @game.valid?
  end


end