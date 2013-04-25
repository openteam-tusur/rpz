class GroupsController < ApplicationController
  inherit_resources

  belongs_to :year do
    belongs_to :faculty
  end

  actions :index, :show, :new, :create, :edit, :update

  has_scope :by_course

private
  alias_method :old_build_resource, :build_resource

  def build_resource
    old_build_resource.tap do |o|
      o.year_id = Year.find(params[:year_id]).id
    end
  end
end
