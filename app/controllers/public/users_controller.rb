class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user

  def show
    if params[:show_private] == '1'
    # '1' の場合、プライベートな投稿も表示
      @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(16)
    else
    # それ以外の場合、公開されている投稿のみ表示
      @posts = @user.posts.public_and_newest.page(params[:page]).per(16)
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to mypage_path, notice: '会員情報の更新が完了しました。'
    else
      render :edit
    end
  end

  def flowering
    @flowering_posts = @user.flowering_posts.page(params[:page]).per(16)
  end

  private

  def set_current_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

end
