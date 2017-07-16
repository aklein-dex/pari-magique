require 'test_helper'


class MemberTest < ActiveSupport::TestCase

  def setup
    @member = members(:member1)
  end

  test "should be valid" do
    assert @member.valid?
  end



end