class Ability
  include CanCan::Ability

  def initialize user, namespace
    user ||= User.new
    if user.is_admin?
      can :read, :all
      can :manage, Subject
      can [:edit, :destroy], User do |other_user|
        user != other_user
      end
    else
      can [:read, :create], Exam
      if namespace == "admin"
        cannot :manage, :all
      end
    end
  end
end
