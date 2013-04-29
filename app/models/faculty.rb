# encoding: utf-8

class Faculty < ActiveRecord::Base
  attr_accessible :abbr, :title

  has_many :courses, dependent: :destroy
  has_many :groups, through: :courses, order: 'groups.course ASC, groups.number ASC'
  has_many :group_semesters, source: :semesters, through: :groups
  has_many :educations, through: :group_semesters

  before_save :set_slug

  alias_attribute :to_s, :abbr

private
  def set_slug
    self.slug = Russian.translit(self.abbr).downcase
  end
end
