class FacultiesController < ApplicationController
 inherit_resources

 belongs_to :year

 actions :show
end
