class CommentAbillity
    include CanCan::Ability
  
    def initialize(user)
      can :read, Comment
      return if user.nil?
      
      can :create , Comment
      can :edit , Comment, user: user
      can :destroy , Comment, user: user
      
    end
  end