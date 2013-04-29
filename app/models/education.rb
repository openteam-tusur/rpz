# encoding: utf-8

class Education < ActiveRecord::Base
  attr_accessible :cycle_code, :cycle_title

  belongs_to :chair
  belongs_to :discipline
  belongs_to :semester, class_name: 'GroupSemester', foreign_key: :group_semester_id
  belongs_to :stream

  has_many :checks,    dependent: :destroy
  has_many :trainings, dependent: :destroy

  delegate :abbr, :title,  to: :chair, prefix: true
  delegate :group, to: :semester
  delegate :title, to: :discipline, prefix: true
end
