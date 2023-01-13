class EventAbillity
    include CanCan::Ability
  
    def initialize(user)
      can :read, Event
      return if user.nil?
      
      can :create , Event
      can :edit , Event, user: user
      can :destroy , Event, user: user
      
    end
  end