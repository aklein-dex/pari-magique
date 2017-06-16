class Ability
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new # guest user (not logged in)

    if user.role? :member
      can [:create, :update], League
    end

    if user.role? :manager

    end

    if user.role? :admin
      can :manage, :all
    end

  end
end
