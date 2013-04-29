# encoding: utf-8

class Faculty < ActiveRecord::Base
  extend FriendlyId

  attr_accessible :abbr, :title

  has_many :courses, dependent: :destroy, order: :number
  has_many :groups, through: :courses
  has_many :group_semesters, source: :semesters, through: :groups
  has_many :educations, through: :group_semesters
  belongs_to :year

  alias_attribute :to_s, :abbr

  friendly_id :abbr, use: :slugged
end
