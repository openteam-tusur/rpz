class Check < ActiveRecord::Base
  belongs_to :education
  attr_accessible :kind, :title
end
