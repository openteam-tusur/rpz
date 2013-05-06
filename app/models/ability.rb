# encoding: utf-8

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    can :manage, :application if user.permissions.any?
    can :manage, :all if user.manager?

    if user.operator?
      can :read, :all
      can :manage, Stream do |stream|
        user.faculties.include? stream.faculty
      end
      can [:update, :edit], GroupSemester do |group_semester|
        user.faculties.include? group_semester.group.course.faculty
      end
    end
  end
end
