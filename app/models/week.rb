# encoding: utf-8

class Week < ActiveRecord::Base
  attr_accessible :number, :semester_id, :starts_on

  belongs_to :semester
  belongs_to :year

  def title
    "#{number} неделя с #{I18n.l starts_on, :format => :long}"
  end

  def break_week?
    starts_on == semester.breaks_on_week.starts_on
  end
end
