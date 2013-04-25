class User < ActiveRecord::Base
  sso_auth_user

  has_many :contexts, :through => :permissions, :source => :context, :source_type => 'Faculty', :uniq => true

  searchable do
    text :email
    text(:full_name) { [last_name, first_name, name, nickname].delete_if(&:blank?).join(' ') }
  end
end
