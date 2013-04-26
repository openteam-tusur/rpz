# encoding: utf-8

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    can :manage, :application
    can :manage, [User, Permission, Year] if user.manager?
  end
end
