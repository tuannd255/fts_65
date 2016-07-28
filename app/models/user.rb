class User < ActiveRecord::Base
  has_many :exams, dependent: :destroy
  has_many :suggest_questions, dependent: :destroy
end
