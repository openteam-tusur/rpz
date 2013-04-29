# encoding: utf-8

class Group < ActiveRecord::Base
  extend FriendlyId

  attr_accessible :budget_students_count, :course, :number, :payment_students_count, :semesters_attributes, :year_forming

  belongs_to :chair
  belongs_to :course
  has_one :faculty, through: :course

  has_one :faculty, :through => :course
  has_one :year, through: :faculty
  has_many :educations, through: :semesters
  has_many :semesters, class_name: 'GroupSemester', dependent: :destroy, order: 'id ASC'
  has_many :year_semesters, source: :semesters, class_name: 'Semester', through: :year

  accepts_nested_attributes_for :semesters

  validates_presence_of :course, :number, :year_forming

  after_save :create_semesters

  scope :archived,              ->(archived) { where(archived: true).order(:number) }
  scope :not_archived,          -> { where(archived: false).order(:number) }
  scope :verified,              -> { where(verified: true).order(:number) }
  scope :not_verified,          -> { where(verified: false).order(:number) }
  scope :with_subspeciality,    -> { where 'subspeciality_id IS NOT NULL' }
  scope :without_subspeciality, -> { where subspeciality_id:  nil }
  scope :without_educations,    -> { includes(:educations).where('educations.id IS NULL') }

  friendly_id :number

  def to_s
    "гр. #{number}"
  end

  def change_archived_state
    self.archived = (archived? ? false : true)
    self.save
  end

  def change_verified_state
    self.verified = (verified? ? false : true)
    self.save
  end

  private

  def create_semesters
    year.semesters.each do |year_semester|
      semester = semesters.find_or_initialize_by_semester_id(year_semester.id)
      if semester.new_record?
        semester.starts_on_week = year_semester.starts_on_week
        semester.breaks_on_week = year_semester.breaks_on_week
        semester.ends_on_week = year_semester.ends_on_week
        semester.save!
      end
    end
  end
end
