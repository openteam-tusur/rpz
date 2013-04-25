# encoding: utf-8

require 'open-uri'
require 'progress_bar'

class SubspecialityImporter < BaseImporter

  def self.sync
    bar = ProgressBar.new(year.groups.count/10)
    year.groups.each_with_index do |group, index|
      bar.increment! if index%10 == 0
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

  def self.subspeciality_response(group)
    begin
      open(URI.encode("#{Settings['plans.url']}/api/v1/subspecialities/by_group/#{group.number}")).read
    rescue
      warn "что-то  plans не отвечают #{group.number}"
      return 'null'
    end
  end

end
