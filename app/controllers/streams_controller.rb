class StreamsController < ApplicationController
  inherit_resources

  belongs_to :year
  belongs_to :faculty
  belongs_to :course

  has_scope :by_semester_title

  def index
    index! {
      @semester = @year.semesters.where(title: params[:by_semester_title]).first
    }
  end

  def create
    create! {
      @semester = @year.semesters.where(title: params[:by_semester_title]).first

      request.referer
    }
  end

  def destroy
    destroy! { request.referer }
  end
end
