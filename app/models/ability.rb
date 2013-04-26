# encoding: utf-8

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    can :manage, :application if user.permissions.any?
    can :manage, :all if user.manager?
  end
end
