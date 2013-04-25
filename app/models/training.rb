class Training < ActiveRecord::Base
  belongs_to :education
  attr_accessible :kind, :planned_loading, :title
end
