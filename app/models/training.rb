# encoding: utf-8

class Training < ActiveRecord::Base
  extend Enumerize

  attr_accessible :kind, :planned_loading, :title

  belongs_to :education

  enumerize :kind, in: [:lab, :lecture, :csr, :practice]
end
