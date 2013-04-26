class GroupSemester < ActiveRecord::Base
  belongs_to :group
  belongs_to :starts_on_week, :class_name => "Week"
  belongs_to :breaks_on_week, :class_name => "Week"
  belongs_to :ends_on_week, :class_name => "Week"
  belongs_to :semester

  has_many :educations, dependent: :destroy
  has_many :trainings, through: :educations

  scope :autumn, -> { joins(:semester).where('semesters.title' => :autumn) }
  scope :spring, -> { joins(:semester).where('semesters.title' => :spring) }

  def number
    semester_number = group.course*2 -1
    semester_number += 1 if semester.title.spring?
    semester_number
  end

  def weeks_count
    weeks.count
  end

  def weeks
    semester.year.weeks.where(:number => [starts_on_week.number..ends_on_week.number])
  end

  def css_class_for(week)
    'breaks' if week.eql?(breaks_on_week)
  end

  def summ_planned_loading
    trainings.sum(&:planned_loading)
  end
end
