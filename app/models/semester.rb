# encoding: utf-8

class Semester < ActiveRecord::Base
  extend Enumerize

  attr_accessible :breaks_on, :ends_on, :starts_on

  belongs_to :year
  has_many :weeks

  has_one :starts_on_week, class_name: 'Week', conditions: proc { { starts_on: self.starts_on } }
  has_one :breaks_on_week, class_name: 'Week', conditions: proc { { starts_on: self.breaks_on } }
  has_one :ends_on_week, class_name: 'Week', conditions: proc { { starts_on: self.ends_on } }

  validates_presence_of :breaks_on, :ends_on, :starts_on

  enumerize :title, :in => [:spring, :autumn]

  def to_s
    ''.tap do |s|
      s << title_text
      s << " с #{I18n.l starts_on, :format => :long} по #{I18n.l ends_on, :format => :long}, ломка - #{I18n.l breaks_on, :format => :long}."
      s << " Всего #{weeks.count} нед."
    end
  end

end
