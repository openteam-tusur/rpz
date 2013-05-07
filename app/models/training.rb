# encoding: utf-8

class Training < ActiveRecord::Base
  attr_accessible :kind, :planned_loading, :title, :monitored
  belongs_to :education
  has_one :semester, through: :education
  has_many :loadings, dependent: :destroy

  def loading_at(week)
    loadings.find_or_create_by_week_id(week.id)
  end

  def summ_loadings
    loadings.where(week_id: semester.weeks).map(&:value).compact.sum
  end
end
