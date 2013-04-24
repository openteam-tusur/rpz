class User < ActiveRecord::Base
  sso_auth_user

  has_many :permissions
end
