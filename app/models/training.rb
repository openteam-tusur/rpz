# encoding: utf-8

class Training < ActiveRecord::Base
  extend Enumerize
  attr_accessible :kind, :planned_loading, :title, :monitored

  belongs_to :education

  has_one :faculty, :through => :education
  has_one :semester, through: :education
  has_many :loadings, dependent: :destroy

  enumerize :kind, :in => {:lecture => 1, :practice => 2, :lab => 3, :csr => 4}, :scope => true, :predicates => true

  def loading_at(week)
    loadings.find_or_create_by_week_id(week.id)
  end

  def summ_loadings
    loadings.where(week_id: semester.weeks).map(&:value).compact.sum
  end

  def monitored_title
    monitored? ? 'Требуется' : 'Не требуется'
  end

  def change_monitored_state
    self.monitored = (monitored? ? false : true)
    self.save
  end
end
