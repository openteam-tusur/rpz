class PermissionsController < ApplicationController
  sso_load_and_authorize_resource

  actions :new, :create, :destroy

  belongs_to :user

  protected

  def smart_collection_url
    users_path
  end
end
