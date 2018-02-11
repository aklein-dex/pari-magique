class Ability
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new # guest user (not logged in)

    if user.role? :member
      can [:create], Request
      can [:update], Request do |request|
        user.is_coach?(request.league.id)
      end

      can [:create], League
      can [:read], League do |league|
        user.is_player?(league.id)
      end
      
      can [:update, :destroy], League do |league|
        user.is_coach?(league.id)
      end

      can [:read, :group, :guesses], Tournament

      can [:create], Guess
      can [:read, :update], Guess do |guess|
        user.id == guess.member.user_id
      end
    end

    if user.role? :manager

    end

    if user.role? :admin
      can :manage, :all
    end

  end
end
