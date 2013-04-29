class StreamsController < ApplicationController
  def index
    @faculty = Faculty.find(params[:faculty_id])
  end
end
