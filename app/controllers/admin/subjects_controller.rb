class Admin::SubjectsController < ApplicationController
  load_and_authorize_resource

  def new
  end

  def create
    if @subject.save
      flash[:success] = t "subjects.create.success"
      redirect_to admin_subjects_path
    else
      render :new
    end
  end

  private
  def subject_params
    params.require(:subject).permit :name, :question_number, :duration
  end
end
