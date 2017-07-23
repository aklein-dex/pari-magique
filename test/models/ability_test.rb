require 'test_helper'


class AbilityTest < ActiveSupport::TestCase

  test "normal user can create a request but not update/destroy it" do
    user = users(:user1)
    league = leagues(:league2)
    ability = Ability.new(user)
    assert ability.can?(:create, Request.new(:user => user))
    # need to be a coach to delete/update
    assert ability.cannot?(:destroy, Request.new)
    assert ability.cannot?(:update, Request.new(:user => user, :league => league))
  end

  test "non member can only create a league" do
    user = users(:user1)
    ability = Ability.new(user)
    assert ability.can?(:create, League.new)
    # need to be coach to delete/update a league
    assert ability.cannot?(:destroy, League.new)
    assert ability.cannot?(:update, League.new)
    # need to be a player to see a league
    assert ability.cannot?(:read, League.new)
  end

  test "coach can create/update a request" do
    # user 1 is a coach of league 1
    user = users(:user1)
    other = users(:user2)
    league = leagues(:league1)
    ability = Ability.new(user)
    assert ability.can?(:create,  Request.new(:user => user))
    assert ability.can?(:update,  Request.new(:user => other, :league => league))
    # a coach can't delete a request, just reject it
    assert ability.cannot?(:destroy, Request.new(:user => other, :league => league))
  end
end