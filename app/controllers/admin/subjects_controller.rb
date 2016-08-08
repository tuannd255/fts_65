class Admin::SubjectsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: :index

  def index
    @search = Subject.search params[:q]
    @subjects = @search.result.order(:name).page params[:page]
    @search.build_condition
  end

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

  def show
  end

  def edit
  end

  def update
    if @subject.update_attributes subject_params
      flash[:success] = t "subjects.update.success"
      redirect_to admin_subject_path @subject
    else
      render :edit
    end
  end

  def destroy
    if @subject.destroy
      flash[:success] = t "subjects.delete.success"
    else
      flash[:success] = t "subjects.delete.fail"
    end
    redirect_to admin_subjects_path
  end

  private
  def subject_params
    params.require(:subject).permit :name, :question_number, :duration
  end
end
