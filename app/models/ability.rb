# encoding: utf-8

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    can :manage, :application if user.manager?
    can :manage, [User, Permission] if user.manager?
  end
end
