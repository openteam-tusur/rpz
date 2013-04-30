class Loading < ActiveRecord::Base
  belongs_to :week
  belongs_to :training
  has_one :education, through: :training
  attr_accessible :value
end
