class Week < ActiveRecord::Base
  attr_accessible :number, :starts_on

  belongs_to :semester
  belongs_to :year
end
