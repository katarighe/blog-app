class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :read, :all
      can :manage, Post, author_id: user.id
      can :destroy, Comment, author_id: user.id
      can :manage, Comment, post: { author_id: user.id }
    end
  end
end
