class Question < ActiveRecord::Base
  belongs_to :subject

  has_many :results, dependent: :destroy
  has_many :answers, dependent: :destroy

  validates :question, presence: true

  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: lambda {|a| a[:answer].blank?}

  enum question_type: [:single_choice, :multiple_choice, :text]

  scope :random, ->{order "RANDOM()"}

  RANSACKABLE_ATTRIBUTES = ["id", "question"]

  def self.ransackable_attributes auth_object = nil
    RANSACKABLE_ATTRIBUTES + _ransackers.keys
  end
end
