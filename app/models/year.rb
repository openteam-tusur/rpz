class Year < ActiveRecord::Base
  attr_accessible :title, :autumn_semester_attributes, :spring_semester_attributes

  has_many :semesters
  has_one :spring_semester, :foreign_key => :year_id, :class_name => Semester, :conditions => { :title => :spring }
  has_one :autumn_semester, :foreign_key => :year_id, :class_name => Semester, :conditions => { :title => :autumn }
  has_many :weeks

  accepts_nested_attributes_for :autumn_semester, :spring_semester
  validates_presence_of :title
  normalize_attribute :title

  delegate :starts_on, :to => :autumn_semester, :allow_nil => true
  delegate :ends_on,   :to => :spring_semester, :allow_nil => true

  after_save :check_weeks

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
    dates.each_with_index do |date, index|
      weeks.find_or_create_by_number_and_starts_on :starts_on => date, :number => index+1
    end
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
