class Stream < ActiveRecord::Base
  attr_accessible :title

  belongs_to :course
  belongs_to :semester

  has_many :educations
end
