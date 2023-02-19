class EventAbility
    include CanCan::Ability

    def initialize(user)
      can [:show, :read], Event
      return if user.nil?

      can :create , Event
      can :update , Event, user: user
      can :destroy , Event, user: user

      if user.admin?
        can :manage, :all # admins can manage all resources
      end
    end
end