class User < ActiveRecord::Base
  sso_auth_user

  has_many :faculties, :through => :permissions, :source => :context, :source_type => 'Faculty', :uniq => true

  searchable do
    boolean(:has_permissions) { permissions.any? }
    text :email
    text(:full_name) { [last_name, first_name, name, nickname].delete_if(&:blank?).join(' ') }
  end

  def manager?
    permissions.where(role: 'manager').any?
  end
end
