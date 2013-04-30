# encoding: utf-8

class GroupSemester < ActiveRecord::Base
  attr_accessible :semester_id, :starts_on_week_id, :breaks_on_week_id, :ends_on_week_id, :loading_values
  attr_accessor :loading_values

  belongs_to :group
  belongs_to :starts_on_week, :class_name => "Week"
  belongs_to :breaks_on_week, :class_name => "Week"
  belongs_to :ends_on_week, :class_name => "Week"
  belongs_to :semester

  has_many :educations, dependent: :destroy, :order => 'cycle_code ASC'
  has_many :trainings, through: :educations

  scope :autumn, -> { joins(:semester).where('semesters.title' => :autumn) }
  scope :spring, -> { joins(:semester).where('semesters.title' => :spring) }
  scope :by_semester_title, ->(title) { joins(:semester).where('semesters.title' => title) }

  delegate :title, :title_text, :to => :semester

  after_save :save_loading_values

  def number
    semester_number = group.course.number*2 -1
    semester_number += 1 if semester.title.spring?
    semester_number
  end

  def weeks_count
    weeks.count
  end

  def weeks
    semester.year.weeks.where(:number => [starts_on_week.number..ends_on_week.number]).order('number ASC')
  end

  def css_class_for(week)
    'breaks' if week.eql?(breaks_on_week)
  end

  def summ_planned_loading
    trainings.sum(&:planned_loading)
  end

  def summ_loading_value(weeks = weeks)
    Loading.where(:training_id => trainings, :week_id => weeks).map(&:value).compact.sum
  end

  def summ_loading_value_at(week)
    summ_loading_value(week)
  end

  private
  def save_loading_values
    loading_values.each do |loading_id, value|
      Loading.find(loading_id).update_attribute(:value, value['value'])
    end if loading_values
  end
end
