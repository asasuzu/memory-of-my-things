class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_user, only: [:show, :update]

  def index
    @users = User.page(params[:page]).per(20)
  end

  def show
    @posts = @user.posts.public_and_newest.page(params[:page])
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "ステータスの更新に成功しました"
    else
      flash.now[:alert] = "ステータスの更新に失敗しました"
      @user.reload # 更新に失敗した時ラジオボタンの選択状態が変わらないようにするため。
      @posts = @user.posts.public_and_newest.page(params[:page])
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:is_active)
  end

  def ensure_user
    @user = User.find(params[:id])
  end

end
