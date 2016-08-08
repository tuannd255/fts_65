class Admin::SuggestQuestionsController < ApplicationController
  load_and_authorize_resource

  def index
    @search = @suggest_questions.search params[:q]
    @suggest_questions = @search.result.page params[:page]
  end

  def show
  end

  def update
    if @suggest_question.update_attributes status: params[:status]
      flash[:success] = t "suggest_questions.update_success"
    else
      flash[:danger] = t "suggest_questions.update_fail"
    end
    redirect_to admin_suggest_questions_path
  end
end
