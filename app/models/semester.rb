class Semester < ActiveRecord::Base
  extend Enumerize

  attr_accessible :breaks_on, :ends_on, :starts_on

  belongs_to :year
  has_many :weeks

  validates_presence_of :breaks_on, :ends_on, :starts_on

  enumerize :title, :in => [:spring, :autumn]
end
