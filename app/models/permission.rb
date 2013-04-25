class Permission < ActiveRecord::Base
  extend Enumerize
  attr_accessible :context_id, :role

  belongs_to :context, polymorphic: true
  belongs_to :user

  validates_presence_of :context_id

  before_create :set_context_type

  enumerize :role, in: [:manager, :operator]

  sso_auth_permission roles: [:manager, :operator]

  private

  def set_context_type
    self.context_type = Faculty.model_name
  end
end
