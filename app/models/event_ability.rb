class EventAbility
    include CanCan::Ability
  
    def initialize(user)
      can :read, Event
      return if user.nil?
      
      can :create , Event
      can :update , Event, user: user
      can :destroy , Event, user: user
      
    end
end