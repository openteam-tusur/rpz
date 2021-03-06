# encoding: utf-8

class YearsController < ApplicationController
  sso_load_and_authorize_resource

  has_scope :sorted_by_title, :default => 1 do |controller, scope|
    scope.order(:title)
  end

private

  alias_method :old_build_resource, :build_resource

  def build_resource
    old_build_resource.tap do |object|
      object.title     = object.title || "#{Date.today.year} - #{Date.today.next_year.year} учебный год"
      @spring_semester = object.spring_semester || object.build_spring_semester
      @autumn_semester = object.autumn_semester || object.build_autumn_semester
    end
  end
end
