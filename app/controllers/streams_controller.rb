class StreamsController < ApplicationController
  inherit_resources

  belongs_to :year
  belongs_to :faculty
  belongs_to :course

  has_scope :by_semester_title
end
