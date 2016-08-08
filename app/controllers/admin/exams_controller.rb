class Admin::ExamsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: :edit

  def index
    @search = @exams.search params[:q]
    @exams = @search.result.includes(:subject).page params[:page]
  end

  def edit
    @exam = Exam.includes(results: [question: :answers])
      .find_by id: params[:id]
  end

  def update
    if @exam.update_attributes exam_params
      update_state_result
      update_score
      flash[:success] = t "exams.updated"
    else
      flash[:danger] = t "exams.update_fail"
    end
    redirect_to admin_exams_path
  end

  private
  def exam_params
    params.require(:exam).permit :status, :score,
      results_attributes: [:id, :state]
  end

  def update_state_result
    @exam.update_state_for_results if @exam.uncheck?
    redirect_to admin_exams_path if @exam.init? || @exam.testing?
  end

  def update_score
    @exam.update_attributes score: @exam.results.result_states.size
  end
end
