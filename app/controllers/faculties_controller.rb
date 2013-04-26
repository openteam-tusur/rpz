class FacultiesController < ApplicationController
  sso_load_and_authorize_resource

  belongs_to :year

  actions :show
end
