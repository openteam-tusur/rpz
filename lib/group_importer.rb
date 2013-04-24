# encoding: utf-8

require 'open-uri'
require 'progress_bar'

class GroupImporter
  attr_accessor :bar

  def self.sync
    groups_attributes = JSON.parse(contingent_response)
    bar = ProgressBar.new(groups_attributes.size/10)
    groups_attributes.each_with_index do |group_attributes, index|
      faculty = faculty(group_attributes['education']['faculty'])
      group = faculty.groups.find_or_initialize_by_number_and_year_id(group_attributes['group_name'], year.id)
      group.year_forming = group_attributes['year_forming']
      group.save!
      bar.increment! if index%10 == 0
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
end
