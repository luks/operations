class Ability

  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role == "admin"
      can :manage, :all
    elsif user.role == "operator"
      can :read, [Day, DayCollection ]
      can :manage, DayCollection, :user_id => user.id
      cannot [:multiple,:admin_day, :confirm], DayCollection
    end
  end
end
