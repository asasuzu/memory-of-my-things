class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_user, only: [:show, :edit, :update]
  
  def index
    @users = User.page(params[:page])
  end

  def show
    @posts = @user.posts.public_and_newest.page(params[:page])
  end

  def update
    @user.update(user_params) ? (redirect_to admin_user_path(@user)) : (render :show)
  end

  private

  def user_params
    params.require(:user).permit(:is_active)
  end

  def ensure_user
    @user = User.find(params[:id])
  end

end
