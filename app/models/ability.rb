class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)

    if user.role? :member or user.role? :manager
      can [:create], Request
      can [:update], Request do |request|
        user.is_coach?(request.faction.id)
      end

      can [:create], Faction
      can [:read], Faction do |faction|
        user.is_player?(faction.id)
      end

      can [:update, :destroy], Faction do |faction|
        user.is_coach?(faction.id)
      end

      can [:read, :group, :guesses, :ranking], Tournament

      can [:create], Guess
      can [:read, :update], Guess do |guess|
        user.id == guess.member.user_id
      end
    end

    if user.role? :manager
      can [:read, :update], Game
    end

    if user.role? :admin
      can :manage, :all
    end

  end
end
