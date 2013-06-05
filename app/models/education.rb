# encoding: utf-8

class Education < ActiveRecord::Base
  attr_accessible :cycle_code, :cycle_title, :gpo_alternative

  belongs_to :chair
  belongs_to :discipline
  belongs_to :semester, class_name: 'GroupSemester', foreign_key: :group_semester_id
  belongs_to :stream

  has_one :group, :through => :semester
  has_one :course, :through => :group
  has_one :faculty, :through => :course
  has_many :checks,    dependent: :destroy
  has_many :trainings, dependent: :destroy, order: :kind

  delegate :abbr, :title,  to: :chair, prefix: true
  delegate :title, to: :discipline, prefix: true

  scope :ordered_by_discipline, ->{ joins(:discipline).order('ascii(disciplines.title) ASC') }
  scope :ordered_by_group,      ->{ joins(:group).order('groups.number ASC') }

  def gpo_alternative_title
    gpo_alternative? ? 'Альтернатива ГПО' : 'Обычный предмет'
  end

  def change_gpo_alternative_state
    self.gpo_alternative = (gpo_alternative? ? false : true)
    self.save
  end
end
