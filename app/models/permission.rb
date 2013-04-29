# encoding: utf-8

class Permission < ActiveRecord::Base
  extend Enumerize
  attr_accessible :context_id, :role

  belongs_to :context, polymorphic: true
  belongs_to :user

  validates_presence_of :context_id, unless: :role_manager?
  validates_uniqueness_of :user_id, scope: [:context_id]

  before_create :set_context_type, if: :context_id?

  enumerize :role, in: [:manager, :operator], predicates: { prefix: true }

  sso_auth_permission roles: [:manager, :operator]

  def to_s
    context.title if context
  end

  private

  def set_context_type
    self.context_type = Faculty.model_name
  end
end
