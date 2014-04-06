class Ability

  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role == "admin"
      can :manage, :all
      cannot :day_confirm, DayCollection, :status_id => 1
      cannot :day_reserve, Datacenter
    elsif user.role == "operator"
      can :read, [Day, DayCollection, Datacenter ]
      can :manage, DayCollection, :user_id => user.id
      can [:day_reserve, :day_destroy, :set_viewport, :set_doubleview], Datacenter
      cannot [:admin_manage_days, :admin_process_days, :day_confirm], DayCollection
      can [:edit, :update, :show], User, :id => user.id

    end
  end
end
