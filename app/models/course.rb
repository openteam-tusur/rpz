# encoding: utf-8

class Course < ActiveRecord::Base
  extend FriendlyId

  attr_accessible :number

  belongs_to :faculty

  has_many :groups, dependent: :destroy, :order => 'number ASC'
  has_many :active_groups, class_name: 'Group', conditions: { archived: false }, order: :number
  has_many :group_semesters, source: :semesters, through: :active_groups
  has_many :educations, through: :group_semesters
  has_many :streams

  def unstreamed_educations(semester_title)
    educations.joins(:semester => :semester).joins(:discipline).
      where(stream_id: nil).where('semesters.title' => semester_title).order('disciplines.title')
  end

  friendly_id :number
end
