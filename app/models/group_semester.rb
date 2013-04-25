class GroupSemester < ActiveRecord::Base
  belongs_to :group
  belongs_to :starts_on_week, :class_name => "Week"
  belongs_to :breaks_on_week, :class_name => "Week"
  belongs_to :ends_on_week, :class_name => "Week"
  belongs_to :semester
end
