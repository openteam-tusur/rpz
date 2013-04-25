class Manage::UsersController < Manage::ApplicationController
  actions :index

  has_scope :page, :default => 1

  def index
    @users = User.search {
      keywords(params[:q])
      paginate(page: params[:page], per_page: 10)
    }.results
  end

end
