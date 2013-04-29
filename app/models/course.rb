# encoding: utf-8

class Course < ActiveRecord::Base
  attr_accessible :number

  belongs_to :faculty

  has_many :groups, dependent: :destroy

  def to_s
    number
  end
end
