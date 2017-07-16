require 'test_helper'


class RequestTest < ActiveSupport::TestCase

  def setup
    @request = requests(:request1)
  end

  test "should be valid" do
    assert @request.valid?
  end

  test "member should be present" do
    @request.user_id = nil
    assert_not @request.valid?
  end

  test "league should be present" do
    @request.league_id = nil
    assert_not @request.valid?
  end

  test "status should be present" do
    @request.status = nil
    assert_not @request.valid?
  end

end