# encoding: utf-8

class Chair < ActiveRecord::Base
  belongs_to :year
  before_save :set_slug

  private

  def set_slug
    self.slug = Russian.translit(self.abbr).downcase
  end
end
