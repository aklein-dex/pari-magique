require 'test_helper'


class TeamTest < ActiveSupport::TestCase

  def setup
    @france = teams(:france)
  end

  test "should be valid" do
    assert @france.valid?
  end

  test "name should be present" do
    @france.name = nil
    assert_not @france.valid?
  end

  test "code should be present" do
    @france.code = nil
    assert_not @france.valid?
  end

  test "flag should be present" do
    @france.flag = nil
    assert_not @france.valid?
  end

  test "selection should be present" do
    @france.selection = nil
    assert_not @france.valid?
  end

  test "name should not be too long" do
    @france.name = "a" * 21
    assert_not @france.valid?
  end

  test "code should not be too long" do
    @france.code = "a" * 4
    assert_not @france.valid?
  end

  test "flag should not be too long" do
    @france.flag = "a" * 21
    assert_not @france.valid?
  end
end