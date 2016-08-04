class Answer < ActiveRecord::Base
  belongs_to :question

  has_many :results, dependent: :destroy

  scope :answer_corrects, ->{where is_correct: true}
end
