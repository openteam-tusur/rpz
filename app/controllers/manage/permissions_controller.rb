class Manage::PermissionsController < Manage::ApplicationController
  actions :new, :create, :destroy

  belongs_to :user

  def create
    create! { manage_users_path }
  end

  def destroy
    destroy! { manage_users_path }
  end
end
