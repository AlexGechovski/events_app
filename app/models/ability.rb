# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Event, :all
    
    return unless user.present?
    can :manage, Event, user_id: user.id

    return unless user.admin?  # additional permissions for administrators
    can :manage, all
  end
end
