class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_current_user, only: [:mypage, :edit, :update, :destroy, :flowering]

  def mypage
    if params[:show_private] == '1'
    # '1' の場合、プライベートな投稿も表示
      @posts = @user.posts.order(created_at: :desc).page(params[:page])
    else
    # それ以外の場合、公開されている投稿のみ表示
      @posts = @user.posts.public_and_newest.page(params[:page])
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.public_and_newest.page(params[:page])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to mypage_path, notice: '会員情報の更新が完了しました'
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit
    end
  end

  def flowering
    @flowering_posts = @user.flowering_posts.page(params[:page])
  end

  private

  def set_current_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

end
