class User < ActiveRecord::Base
  sso_auth_user

  has_many :contexts, :through => :permissions, :source => :context, :source_type => 'Faculty', :uniq => true
end
