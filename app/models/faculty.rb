class Faculty < ActiveRecord::Base
  attr_accessible :abbr, :title
  before_save :set_slug

  has_many :groups, :dependent => :destroy

  private

  def set_slug
    self.slug = Russian.translit(self.abbr).downcase
  end
end
