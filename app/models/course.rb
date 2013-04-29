# encoding: utf-8

class Course < ActiveRecord::Base
  extend FriendlyId

  attr_accessible :number

  belongs_to :faculty

  has_many :groups, dependent: :destroy
  has_many :group_semesters, source: :semesters, through: :groups
  has_many :educations, through: :group_semesters

  friendly_id :number
end
