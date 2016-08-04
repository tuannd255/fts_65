class ExamsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: :index

  def index
    @subjects = Subject.order :name
    @exam = Exam.new
    @exams = current_user.exams.includes :subject
  end

  def show
    check_status
    @remaining_time = @exam.remaining_time
  end

  def new
  end

  def create
    @subject = Subject.find_by id: params[:exam][:subject_id]
    if @subject.nil?
      flash[:danger] = t "exams.create_fail"
      redirect_to subjects_path
    else
      @exam = current_user.exams.build exam_params
      if @exam.save
        flash[:success] = t "exams.created"
      else
        flash[:danger] = t "exams.create_fail"
      end
      redirect_to exams_path
    end
  end

  def edit
  end

  def update
    @exam.spent_time = @exam.calculated_spent_time
    if @exam.update_attributes exam_params
      if @exam.time_out? || params[:finish]
        flash[:success] = t "exams.updated"
        @exam.uncheck!
      end
    else
      flash[:danger] = t "exams.update_fail"
    end
    redirect_to exams_path
  end

  private
  def exam_params
    params.require(:exam).permit :user_id, :subject_id,
      results_attributes: [:id, multiple_answers: []]
  end

  def check_status
    @exam = current_user.exams.includes(results: [question: :answers])
      .find_by id: params[:id]
    case @exam.status
    when "init"
      @exam.update_attributes started_at: Time.zone.now, status: :testing
    when "checked"
      flash[:success] = t "exams.result", score: @exam.score
    when "testing"
      flash.now[:danger] = t "exams.finished" if @exam.time_out?
    when "uncheck"
      flash[:danger] = t "flash.cant_access"
      redirect_to exams_path
    end
  end
end
