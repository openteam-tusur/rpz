class CopyLoadingsController < ApplicationController
  authorize_resource :class => false
  before_filter :find_parents

  layout false

  def new
    @groups = @course.groups
  end

  def create
    donor = @course.groups.find(params[:copy_loading][:copy_group_id])

    donor.educations.each do |donor_education|
      donor_discipline = donor_education.discipline
      education = @group.educations.find_by_discipline_id(donor_discipline.id)
      next if education.nil?

      donor_education.trainings.each do |donor_training|

        training = education.trainings.find_by_title(donor_training.title)
        next if training.nil?

        donor_training.loadings.each do |donor_loading|
          loading = training.loadings.select{ |l| l.week.number == donor_loading.week.number }.first
          next if loading.nil?
          loading.update_attributes(:value => donor_loading.value)
        end
      end
    end if donor

    redirect_to [@year, @faculty, @course, @group]
  end


  def find_parents
    @year    = Year.find(params[:year_id])
    @faculty = @year.faculties.find(params[:faculty_id])
    @course  = @faculty.courses.find(params[:course_id])
    @group   = @course.groups.find(params[:group_id])
  end
end
