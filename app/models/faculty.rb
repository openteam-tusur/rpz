# encoding: utf-8

class Faculty < ActiveRecord::Base
  attr_accessible :abbr, :title

  has_many :groups, :dependent => :destroy, :order => 'groups.course ASC, groups.number ASC'

  before_save :set_slug

  alias_attribute :to_s, :abbr

private
  def set_slug
    self.slug = Russian.translit(self.abbr).downcase
  end
end
