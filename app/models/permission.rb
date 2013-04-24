class Permission < ActiveRecord::Base
  attr_accessible :role, :faculty_id

  belongs_to :faculty

  validates_presence_of :faculty

  sso_auth_permission roles: [:manager, :operator]

  extend Enumerize
  enumerize :role, in: [:manager, :operator]
end
