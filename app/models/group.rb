class Group < ActiveRecord::Base
  belongs_to :faculty
  belongs_to :year
  attr_accessible :budget_studens_count, :course, :number, :payment_students_count
  validates_presence_of :faculty, :year

  before_save :set_course

  private

  def set_course
    self.course = self.year.year - year_forming + 1
  end
end
