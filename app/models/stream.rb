class Stream < ActiveRecord::Base
  attr_accessible :title

  belongs_to :course
  belongs_to :semester

  has_many :educations

  scope :by_semester_title, ->(title) { joins(:semester).where('semesters.title' => title) }
end
