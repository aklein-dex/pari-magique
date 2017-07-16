require 'test_helper'


class UserTest < ActiveSupport::TestCase

  def setup
    @admin = users(:admin)
  end

  test "should be valid" do
    assert @admin.valid?
  end

  test "username should be present" do
    @admin.username = nil
    assert_not @admin.valid?
  end


end