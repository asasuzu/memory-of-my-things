class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :ensure_post, only: [:show, :edit, :update, :destroy, :goodbye]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post), notice: "投稿に成功しました"
    else
      render 'new'
    end
  end

  def index
    @posts = Post.public_and_newest.page(params[:page]).per(16)
  end

  def show
    @comment = Comment.new
    # 投稿が公開中　or　投稿したユーザーが現在ログイン中のユーザーの場合
    if @post.is_public || current_user == @post.user
    else
    # 投稿が非公開かつ投稿したユーザーが現在ログインユーザーではない場合
      redirect_to root_path
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "更新に成功しました"
    else
      render 'edit'
    end
  end

  def destroy
    if @post.destroy
      # 管理者がログインしているかを確認
      if admin_signed_in?
        # 管理者側のページにリダイレクト
        redirect_to admin_reports_path, notice: "削除に成功しました"
      else
        # 通常のユーザーの場合、投稿一覧ページにリダイレクト
        redirect_to posts_path, notice: "削除に成功しました"
      end
    else

      render 'edit'
    end
  end
  
  def search
    @keyword = params[:keyword]
    @spend_time = params[:spend_time]

    if @keyword.present? || @spend_time.present?
      @result = Post.search(@keyword, @spend_time).page(params[:page]).per(16)
    else
      @result = []
    end
  end
  
  def goodbye
    @random_message = Message.limit(1).offset(rand(Message.count)).first
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :is_public, :spend_time)
  end

  def ensure_post
    @post = Post.find(params[:id])
  end

end
