# encoding: utf-8

class BaseImporter

  def self.year
    raise "Нет учебного года" unless Year.any?
    @year ||= Year.all.sort_by(&:starts_on).last
  end

  def self.chair(params)
    chair = Chair.find_or_initialize_by_abbr(params['abbr'])
    chair.title = params['title']
    chair.save!
    chair
  end

end
