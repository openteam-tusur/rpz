class Week < ActiveRecord::Base
  attr_accessible :number, :semester_id, :starts_on

  belongs_to :semester
  belongs_to :year
end
