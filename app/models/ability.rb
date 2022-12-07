# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Event, public: true
    return unless user.present?
    can :update, Event, user: user
    can :create, Event, user: user

      # additional permissions for logged in users (they can read their own Events)
    can :read, Event, user: user

    return unless user.admin?  # additional permissions for administrators
    can :read, Event
  end
end
