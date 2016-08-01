class Admin::UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @search = User.search params[:q]
    @users = @search.result.page params[:page]
    @search.build_condition
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "users.updated"
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "users.deleted"
    else
      flash[:danger] = t "users.delete_fail"
    end
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit :email, :username
  end
end
