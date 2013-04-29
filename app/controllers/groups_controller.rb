# encoding: utf-8

class GroupsController < ApplicationController
  sso_load_and_authorize_resource

  belongs_to :year do
    belongs_to :faculty
  end

  actions :index, :show, :new, :create, :edit, :update
  custom_actions :resource => [:change_archived_state, :change_verified_state]

  has_scope :by_course
  has_scope :archived

  def change_archived_state
    change_archived_state!{
      @group.change_archived_state
      redirect_to :action => :index, :by_course => "course_#{@group.course}" and return
    }
  end

  def change_verified_state
    change_verified_state!{
      @group.change_verified_state
      redirect_to :action => :show and return
    }
  end

private
  alias_method :old_build_resource, :build_resource

  def build_resource
    old_build_resource.tap do |o|
      o.year_id = Year.find(params[:year_id]).id
      o.year_semesters.each do |semester|
        s = o.semesters.build :semester_id => semester.id
      end if o.semesters.empty?
    end
  end
end
