class Ability

  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role == "admin"
      can :manage, :all
      cannot :day_confirm, DayCollection, :status_id => 1
      cannot :manage, :day_reserve
    elsif user.role == "operator"
      can :read, [Day, DayCollection, Datacenter ]
      can :manage, DayCollection, :user_id => user.id
      can :manage, Datacenter
      can :manage, :day_reserve
      cannot [:admin_manage_days, :admin_process_days, :day_confirm], DayCollection
    end
  end
end
