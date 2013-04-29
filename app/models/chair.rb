# encoding: utf-8

class Chair < ActiveRecord::Base
  extend FriendlyId

  belongs_to :year

  friendly_id :abbr, use: :slugged
end
