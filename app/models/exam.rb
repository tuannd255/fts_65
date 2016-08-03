class Exam < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject

  has_many :results, dependent: :destroy

  accepts_nested_attributes_for :results, allow_destroy: true

  enum status: {init: 0, testing: 1, uncheck: 2, checked: 3}

  after_create :create_result_for_exam

  def remaining_time
    init? || testing? ? subject.duration * Settings.minutes -
      (Time.zone.now - started_at).to_i : 0
  end

  def time_out?
    uncheck? || checked? || Time.zone.now > started_at +
      subject.duration * Settings.minutes
  end

  def calculated_spent_time
    time = Time.zone.now - started_at
    time > subject.duration * Settings.minutes ?
      subject.duration * Settings.minutes : time
  end

  private
  def create_result_for_exam
    Result.transaction do
      begin
        unless results.any?
          subject.questions.random.limit(
            subject.question_number).each do |question|
              question.results.create! exam: self
          end
        end
      rescue
        raise ActiveRecord::Rollback
      end
    end
  end

  def update_time_status
    if init?
      update_attributes started_at: Time.zone.now, status: :testing
    elsif time_out? && testing?
      update_attributes status: :uncheck
    elsif testing?
      update_attributes spent_time: calculated_spent_time
    end
  end
end
