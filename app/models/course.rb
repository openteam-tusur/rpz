class Course < ActiveRecord::Base
  attr_accessible :number

  belongs_to :faculty

  has_many :groups, dependent: :destroy
end
