class StreamsController < ApplicationController
  sso_load_and_authorize_resource

  belongs_to :year do
    belongs_to :faculty do
      belongs_to :course
    end
  end

  has_scope :by_semester_title

  actions :index, :create, :update, :new, :edit, :destroy
  custom_actions :collection => :search

  def index
    index! {
      @semester = @year.semesters.where(title: params[:by_semester_title]).first
    }
  end

  def create
    create! { semester_year_faculty_course_streams_path(:by_semester_title => @stream.semester.title) }
  end

  def update
    update! { semester_year_faculty_course_streams_path(:by_semester_title => @stream.semester.title) }
  end

  def destroy
    destroy! { request.referer }
  end

  def search
    search!{
      @course     = @faculty.courses.find_by_number(params[:course_number] || params[:course_id])
      @courses    = @faculty.courses
      @group      = @course.groups.find_by_id(params[:group_id]) if @course
      @groups     = @course.groups.order('number ASC')
      @educations = @group.semesters.find_by_semester_id(params[:semester_id]).educations.ordered_by_discipline if @group
      render :partial => 'education_form', :locals => {
        :course => @course,
        :courses => @courses || [],
        :education => nil,
        :educations => @educations || [],
        :group => @group,
        :groups => @groups
      } and return
    }
  end

private
  alias_method :old_build_resource, :build_resource

  def build_resource
    old_build_resource.tap do |s|
      s.semester = @year.semesters.find_by_title(params[:season]) if s.semester.nil?
      s.title = s.educations.first.discipline_title if s.educations.any?
    end
  end
end
