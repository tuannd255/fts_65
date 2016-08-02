class Exam < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject

  has_many :results, dependent: :destroy

  accepts_nested_attributes_for :results, allow_destroy: true

  enum status: {init: 0, testing: 1, uncheck: 2, checked: 3}

  after_create :create_result_for_exam

  private
  def create_result_for_exam
    Result.transaction do
      begin
        unless results.any?
          subject.questions.random.limit(
            subject.question_number).each do |question|
              question.results.create! exam: self
          end
          update_time_status
        end
      rescue
        raise ActiveRecord::Rollback
      end
    end
  end
end
