class Education < ActiveRecord::Base
  belongs_to :semester, class_name: 'GroupSemester', foreign_key: :group_semester_id
  belongs_to :discipline
  belongs_to :chair
  attr_accessible :cycle_code, :cycle_title

  has_many :trainings, dependent: :destroy
  has_many :checks, dependent: :destroy
end
