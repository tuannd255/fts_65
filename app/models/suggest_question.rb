class SuggestQuestion < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject

  has_many :suggest_answers, dependent: :destroy

  validates :question, presence: true

  accepts_nested_attributes_for :suggest_answers, allow_destroy: true,
    reject_if: lambda {|a| a[:answer].blank?}

  enum status: [:wait, :reject, :approve]

  after_update :create_question, if: :approved?

  private
  def approved?
    self.status_changed? from: "wait", to: "approve"
  end

  def create_question
    Question.create question: self.question, question_type: self.question_type,
      subject_id: self.subject_id
  end
end
