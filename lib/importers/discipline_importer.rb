# encoding: utf-8

require 'open-uri'
require 'progress_bar'

class DisciplineImporter

  def self.sync
    bar = ProgressBar.new(year.groups.with_subspeciality.count/10)
    year.groups.with_subspeciality.each_with_index do |group, index|
      bar.increment! if index%10 == 0
      group.semesters.each do |semester|
        JSON.parse(disciplines_response(group, semester)).each do |discipline_attributes|
          discipline = Discipline.find_or_create_by_title(discipline_attributes['title'])
          education = semester.educations.find_or_initialize_by_discipline_id(discipline.id)
          education.chair = chair(discipline_attributes['subdepartment'])
          education.cycle_title = discipline_attributes['cycle']['title']
          education.cycle_code = discipline_attributes['cycle']['code']
          education.save!
          create_trainings(education, discipline_attributes['loadings'])
          create_checks(education, discipline_attributes['checks'])
        end
      end
    end
    nil
  end

  private

  def self.year
    raise "Нет учебного года" unless Year.any?
    @year ||= Year.all.sort_by(&:starts_on).last
  end

  def self.disciplines_response(group, semester)
    begin
      open(URI.encode("#{Settings['plans.url']}/api/v1/disciplines/#{group.subspeciality_id}/#{semester.number}")).read
    rescue
      warn "что-то  plans не отвечают #{group.number}"
      return "[]"
    end
  end


  def self.chair(params)
    chair = Chair.find_or_initialize_by_abbr(params['abbr'])
    chair.title = params['title']
    chair.save!
    chair
  end

  def self.create_trainings(education, options)
    options.each do |training_attributes|
      training = education.trainings.find_or_initialize_by_kind(training_attributes['kind'])
      training.title = training_attributes['kind_text']
      training.planned_loading = training_attributes['value']
      training.save!
    end
  end

  def self.create_checks(education, options)
    options.each do |check_attributes|
      check = education.checks.find_or_initialize_by_kind(check_attributes['kind'])
      check.title = check_attributes['kind_text']
      check.save!
    end
  end

end
