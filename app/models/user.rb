class User < ActiveRecord::Base
  sso_auth_user

  searchable do
    boolean(:has_permissions) { permissions.any? }
    text :email
    text(:full_name) { [last_name, first_name, name, nickname].delete_if(&:blank?).join(' ') }
  end
end
