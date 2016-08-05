class SuggestQuestionsController < ApplicationController
  load_and_authorize_resource
  before_action :load_params, only: [:new, :edit]

  def index
    @search = @suggest_questions.search params[:q]
    @suggest_questions = @search.result.page params[:page]
    @search.build_condition
  end

  def new
    Settings.default_number_of_answers.times {
      @suggest_question.suggest_answers.build}
  end

  def create
    if @suggest_question.save
      flash[:success] = t "questions.create_success"
      redirect_to suggest_questions_path
    else
      load_params
      render :new
    end
  end

  def edit
  end

  def update
    if @suggest_question.update_attributes suggest_question_params
      flash[:success] = t "questions.update_success"
      redirect_to suggest_questions_path
    else
      load_params
      render :edit
    end
  end

  def destroy
    if @suggest_question.destroy
      flash[:success] = t "suggest_questions.deleted"
    else
      flash[:success] = t "suggest_questions.delete_fail"
    end
    redirect_to suggest_questions_path
  end

  private
  def suggest_question_params
    params.require(:suggest_question).permit :question, :question_type,
      :subject_id, :status,
      suggest_answers_attributes: [:id, :answer, :is_correct, :_destroy]
  end

  def load_params
    @subjects = Subject.all
    @question_types = Question.question_types
  end
end
