class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_post, only: [:show, :edit, :update, :destroy]

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
    @posts = Post.where(is_public: true).order(created_at: :desc).page(params[:page]).per(4)
  end

  def show
    @comment = Comment.new
    # 投稿が公開中　or　投稿したユーザーが現在ログイン中のユーザーの場合
    if @post.is_public || current_user == @post.user
    else
    # それ以外の場合、TOPへ遷移
      redirect_to root_path
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "更新に成功しました."
    else
      render 'edit'
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path, notice: "削除に成功しました."
    else
      @comment = Comment.new
      render 'show'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :is_public, :spend_time)
  end

  def ensure_post
    @post = Post.find(params[:id])
  end
end
