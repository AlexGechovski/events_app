class CommentAbility
    include CanCan::Ability

    
  
    def initialize(user)
      can :read, Comment
      return if user.nil?
      
      can :create, Comment
      can :update, Comment, user: user
      can :destroy, Comment, user: user
      
    end
  end