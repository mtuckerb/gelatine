class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
      can :assign_roles
    else
      can :read, :all
      can :update, Reservation, :user => user
      can :create, Reservation
      cannot :assign_roles
    end
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
  

end
