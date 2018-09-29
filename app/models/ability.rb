class Ability
  include CanCan::Ability

  def initialize(user)
    user = current_user
    alias_action :create, :read, :update, :destroy, to: :crud
    case user.type
      when "Customer"
        can [:index, :show], [Customer]
      when "Provider"
        can :crud, [Project]
      when "Admin"
        can :manage, :all
    end
  end
end
