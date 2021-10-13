class Ability
  include CanCan::Ability

  def initialize user
    can :read, Room
    cannot :read, Receipt

    return if user.blank?

    can :read, Receipt, user: user
    can :update, Receipt, user: user
    can :manage,  User, user: user
    return unless user.admin?

    can :manage, :all
  end
end
