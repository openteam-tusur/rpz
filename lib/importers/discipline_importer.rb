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
          p discipline_attributes
        end
        return
      end
      if (response = subspeciality_response(group)) != 'null'
        subspeciality_attributes = JSON.parse(response)
        group.subspeciality_id = subspeciality_attributes['id']
        group.subspeciality_title = subspeciality_attributes['title']
        group.plan_year = subspeciality_attributes['year']
        group.speciality_code = subspeciality_attributes['speciality']['code']
        group.speciality_title = subspeciality_attributes['speciality']['title']
        group.chair = chair(subspeciality_attributes['subdepartment'])
        group.save
      else
        next
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
      return []
    end
  end


  def self.chair(params)
    chair = Chair.find_or_initialize_by_abbr(params['abbr'])
    chair.title = params['title']
    chair.save!
    chair
  end

end
