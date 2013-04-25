class GroupSemester < ActiveRecord::Base
  belongs_to :group
  belongs_to :starts_on_week, :class_name => "Week"
  belongs_to :breaks_on_week, :class_name => "Week"
  belongs_to :ends_on_week, :class_name => "Week"
  belongs_to :semester
  has_many :educations, dependent: :destroy
  scope :autumn, -> { joins(:semester).where('semesters.title' => :autumn) }

  def number
    semester_number = group.course*2 -1
    semester_number += 1 if semester.title.spring?
    semester_number
  end
end
