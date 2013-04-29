# encoding: utf-8

class Week < ActiveRecord::Base
  attr_accessible :number, :semester_id, :starts_on

  belongs_to :semester
  belongs_to :year

  def title
    "#{number} неделя с #{I18n.l starts_on, :format => :long}"
  end
end
