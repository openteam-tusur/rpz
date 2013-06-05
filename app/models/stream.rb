class Stream < ActiveRecord::Base
  attr_accessible :title, :semester_id, :education_ids

  belongs_to :course
  belongs_to :semester

  before_create :check_educations_count
  after_destroy :reset_education_stream_ids

  has_many :courses, :through => :faculty
  has_many :educations
  has_many :trainings, through: :educations
  has_one :faculty, :through => :course

  scope :by_semester_title, ->(title) { joins(:semester).where('semesters.title' => title) }

  def lecture_trainings
    trainings.with_kind(:lecture)
  end

  private

  def check_educations_count
    return false unless educations.many?
  end

  def reset_education_stream_ids
    educations.update_all stream_id: nil
  end

end
