class Stream < ActiveRecord::Base
  attr_accessible :title, :semester_id, :education_ids

  belongs_to :course
  belongs_to :semester

  before_create :check_educations_count
  after_destroy :reset_education_stream_ids

  has_many :educations

  scope :by_semester_title, ->(title) { joins(:semester).where('semesters.title' => title) }

  private

  def check_educations_count
    return false unless educations.many?
  end

  def reset_education_stream_ids
    educations.update_all stream_id: nil
  end
end
