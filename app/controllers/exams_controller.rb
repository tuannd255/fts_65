class ExamsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: :index

  def index
    @subjects = Subject.order :name
    @exam = Exam.new
    @exams = current_user.exams.includes :subject
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

  private
  def exam_params
    params.require(:exam).permit :user_id, :subject_id,
      results_attributes: [:id, multiple_answers: []]
  end
end
