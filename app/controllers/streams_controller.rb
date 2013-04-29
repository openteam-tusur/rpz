class StreamsController < ApplicationController
  inherit_resources

  belongs_to :year
  belongs_to :faculty
  belongs_to :course
  belongs_to :semester

  def collection
  end
end
