class Group < ActiveRecord::Base
  belongs_to :faculty
  belongs_to :year
  belongs_to :chair
  attr_accessible :budget_studens_count, :course, :number, :payment_students_count
  validates_presence_of :faculty, :year, :number

  has_many :semesters, class_name: 'GroupSemester', dependent: :destroy

  before_save :set_course

  after_save :create_semesters

  private

  def set_course
    self.course = self.year.year - year_forming + 1
  end

  def create_semesters
    year.semesters.each do |year_semester|
      semester = semesters.find_or_initialize_by_semester_id(year_semester.id)
      if semester.new_record?
        semester.starts_on_week = year_semester.starts_on_week
        semester.breaks_on_week = year_semester.breaks_on_week
        semester.ends_on_week = year_semester.ends_on_week
        semester.save!
      end
    end
  end
end
