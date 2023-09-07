class Public::PostsController < ApplicationController
  before_action :ensure_post, only: [:show, :edit, :update, :destroy]
  
  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    if post.save
      redirect_to post_path(post), notice: "投稿に成功しました"
    else
      @posts = Post.all
      render 'index'
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "更新に成功しました."
    else
      render 'show'
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path, notice: "削除に成功しました."
    else
      render 'show'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :is_public)
  end

  def ensure_post
    @post = Post.find(params[:id])
  end
end
