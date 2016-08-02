class Admin::QuestionsController < ApplicationController
  load_and_authorize_resource

  def new
    load_params
    Settings.default_number_of_answers.times {@question.answers.build}
  end

  def create
    if @question.save
      flash[:success] = t "questions.create_success"
      redirect_to admin_questions_path
    else
      load_params
      render :new
    end
  end

  def index
  end

  private
  def question_params
    params.require(:question).permit :question, :question_type,
      :subject_id, answers_attributes: [:answer, :is_correct, :_destroy]
  end

  def load_params
    @subjects = Subject.all
    @question_types = Question.question_types
  end
end
