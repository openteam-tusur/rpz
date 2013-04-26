class UsersController < ApplicationController
  sso_load_and_authorize_resource

  actions :index

  has_scope :page, :default => 1

  def index
    @users = User.search {
      keywords(params[:q])
      with :has_permissions, true unless params[:utf8]
      paginate(page: params[:page], per_page: 10)
    }.results
  end
end
