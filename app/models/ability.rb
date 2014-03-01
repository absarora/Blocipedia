class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user
    #alias_action :edit, :to => :update
    #alias_action :new, :to => :create
    alias_action :update, :destroy, :to => :modify

    # if a member, they can manage their own pages 
    # (or create new ones)
    if user.role? :member
      can :manage, Wiki, :user_id => user.id
    end

    # Moderators can delete any post
    if user.role? :moderator
      can :modify, Wiki
    end

    if user.role? :premium
      can :manage, Wiki, :user_id => user.id
      can :manage, Collaboration, :user_id => user.id
    end

    # Admins can do anything
    if user.role? :admin
      can :manage, :all
    end

    can :read, Wiki, public: true
  end
end