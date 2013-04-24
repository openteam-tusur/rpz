# encoding: utf-8

class Year < ActiveRecord::Base
  attr_accessible :title, :autumn_semester_attributes, :spring_semester_attributes

  has_many :semesters
  has_one :spring_semester, :foreign_key => :year_id, :class_name => Semester, :conditions => { :title => :spring }
  has_one :autumn_semester, :foreign_key => :year_id, :class_name => Semester, :conditions => { :title => :autumn }
  has_many :weeks
  has_many :groups

  accepts_nested_attributes_for :autumn_semester, :spring_semester
  validates_presence_of :title
  normalize_attribute :title

  delegate :starts_on, :to => :autumn_semester, :allow_nil => true
  delegate :ends_on,   :to => :spring_semester, :allow_nil => true

  after_save :check_weeks

  def year
    starts_on.year
  end

  def to_s
    ''.tap do |s|
      s << title
      s << " (#{weeks.count} нед. с #{I18n.l starts_on, :format => :long} по #{I18n.l ends_on, :format => :long})"
    end
  end

private

  def check_weeks
    return if old_week_starts_ons == new_week_starts_ons

    if (delta = old_week_starts_ons - new_week_starts_ons).any?
      weeks.where(:starts_on => delta).destroy_all
    end

    if (delta = new_week_starts_ons - old_week_starts_ons).any?
      create_weeks(delta)
    end

    update_week_numbers
  end

  def create_weeks(dates = new_week_starts_ons)
    dates.each do |date|
      weeks.find_or_create_by_semester_id_and_starts_on :semester_id => get_semester_id(date), :starts_on => date
    end
  end

  def get_semester_id(date)
    return autumn_semester.id if date.between?(autumn_semester.starts_on, autumn_semester.ends_on)
    return spring_semester.id if date.between?(spring_semester.starts_on, spring_semester.ends_on)
    nil
  end

  def old_week_starts_ons
    @old_week_starts_ons = weeks.pluck(:starts_on)
  end

  def new_week_starts_ons
    starts_ons = []
    date = starts_on

    while date <= ends_on do
     starts_ons << date
     week = date.next_week
     date = week.beginning_of_week
    end

    @new_week_starts_ons = starts_ons
  end

  def update_week_numbers
    weeks.order('starts_on ASC').each_with_index do |week, index|
      week.update_column :number, index+1
    end
  end
end
