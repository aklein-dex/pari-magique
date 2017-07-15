require 'test_helper'


class StadiumTest < ActiveSupport::TestCase

  def setup
    @stadium = stadia(:stadium1)
  end

  test "should be valid" do
    assert @stadium.valid?
  end

  test "name should be present" do
    @stadium.name = nil
    assert_not @stadium.valid?
  end

  test "city should be present" do
    @stadium.city = nil
    assert_not @stadium.valid?
  end

  test "capacity should be present" do
    @stadium.capacity = nil
    assert_not @stadium.valid?
  end

  test "name should not be too long" do
    @stadium.name = "a" * 21
    assert_not @stadium.valid?
  end

  test "city should not be too long" do
    @stadium.city = "a" * 21
    assert_not @stadium.valid?
  end

  test "capacity should not be negative" do
    @stadium.capacity = -21
    assert_not @stadium.valid?
  end

  test "capacity should not be too large" do
    @stadium.capacity = 1234567
    assert_not @stadium.valid?
  end
end