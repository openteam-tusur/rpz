class Loading < ActiveRecord::Base
  belongs_to :week
  belongs_to :training
  attr_accessible :value
end
