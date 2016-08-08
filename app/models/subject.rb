class Subject < ActiveRecord::Base
  has_many :exams, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :suggest_questions, dependent: :destroy

  validates :name, presence: true
  validates :question_number, presence: true
  validates :duration, presence: true
  validate :check_question_number_and_duration

  private
  def check_question_number_and_duration
    if self.question_number.present? && self.duration.present?
      if self.question_number <= 0
        errors.add :question_number, I18n.t("errors.question_number")
      elsif self.duration <= 0
        errors.add :duration, I18n.t("errors.duration")
      end
    end
  end
end
