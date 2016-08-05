class SuggestQuestion < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject

  has_many :suggest_answers, dependent: :destroy

  validates :question, presence: true

  accepts_nested_attributes_for :suggest_answers, allow_destroy: true,
    reject_if: lambda {|a| a[:answer].blank?}

  enum status: [:wait, :reject, :approve]
end
