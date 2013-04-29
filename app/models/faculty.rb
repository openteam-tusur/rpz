# encoding: utf-8

class Faculty < ActiveRecord::Base
  attr_accessible :abbr, :title

  has_many :courses, dependent: :destroy, order: :number
  has_many :groups, through: :courses
  has_many :group_semesters, source: :semesters, through: :groups
  has_many :educations, through: :group_semesters
  belongs_to :year

  before_save :set_slug

  alias_attribute :to_s, :abbr

private
  def set_slug
    self.slug = Russian.translit(self.abbr).downcase
  end
end
