# encoding: utf-8

require 'open-uri'
require 'progress_bar'

class GroupImporter
  attr_accessor :bar

  def self.sync
    groups_attributes = JSON.parse(contingent_response)
    bar = ProgressBar.new(groups_attributes.size/10)
    groups_attributes.each_with_index do |group_attributes, index|
      bar.increment! if index%10 == 0
      next if (year.year - group_attributes['year_forming'].to_i) > 5
      faculty = faculty(group_attributes['education']['faculty'])
      group = faculty.groups.find_or_initialize_by_number_and_year_id(group_attributes['group_name'], year.id)
      group.year_forming = group_attributes['year_forming']
      group.save!
      build_group_for_first_course(group) if group.course == 2
    end
    nil
  end

  private

  def self.contingent_response
    open("#{Settings['students.url']}/api/v1/groups").read
  end

  def self.year
    raise "Нет учебного года" unless Year.any?
    @year ||= Year.all.sort_by(&:starts_on).last
  end

  def self.faculty(params)
    faculty = Faculty.find_or_initialize_by_abbr(params['short_name'])
    faculty.title = params['faculty_name']
    faculty.save!
    faculty
  end

  def self.build_group_for_first_course(group)
    new_group = group.faculty.groups.new
    new_group.year = group.year
    new_group.number =
      case group.number
      when /^\d.\d/
        group.number[2]=year.year.to_s.last
        group.number
      when /^з-\d{2}/
        group.number[3]=year.year.to_s.last
        group.number
      when /^з-\d{3}/
        group.number[4]=year.year.to_s.last
        group.number
      when /^\d{2}-В/
        group.number[1]=year.year.to_s.last
        group.number
      else
        warn "не могу понять как сгенерировать 1-ый курс для группы #{group.number}"
        return
      end
    new_group.year_forming = year.year
    new_group.save!
  end
end
