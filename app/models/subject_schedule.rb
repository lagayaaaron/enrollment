class SubjectSchedule < ApplicationRecord
  generate_public_uid generator: PublicUid::Generators::HexStringSecureRandom.new(12)

  belongs_to :subject
  belongs_to :instructor

  has_many :admissions
  has_many :students, through: :admissions
  
  validates :subject, :instructor,:location, :day_of_week, presence: true
  validates :start_time, :end_time, :day_of_week,  presence: true
  validate :schedule_conflict, if: -> { errors.empty? }

  def formatted_start_time
    start_time.strftime("%H:%M")
  end

  private

  def schedule_conflict
      overlaps = instructor.subject_schedules
                        .where(day_of_week: day_of_week)
                        .where.not(id: id)
                        .where('start_time < ? AND end_time > ?', end_time, start_time)

      errors.add(:base, 'Instructor schedule conflict') unless overlaps.empty?
  end

end
