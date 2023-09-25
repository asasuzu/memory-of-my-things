class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
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
      flash.now[:alert] = "投稿に失敗しました"
      render 'new'
    end
  end

  def index
    @posts = Post.public_and_newest.page(params[:page])
  end

  def show
    @comment = Comment.new
    # 投稿が非公開or投稿したユーザーが現在ログイン中のユーザーでない場合
    unless @post.is_public || current_user == @post.user
      redirect_to root_path
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "更新に成功しました"
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path, notice: "削除に成功しました"
    else
      flash.now[:alert] = "投稿の削除に失敗しました"
      render :edit
    end
  end

  def search
    @keyword = params[:keyword]
    @spend_time = params[:spend_time]

    if @keyword.present? || @spend_time.present?
      @result = Post.search(@keyword, @spend_time).page(params[:page])
    else
      @result = []
    end
  end
  
  def goodbye
    # 管理者が登録した遺言からランダムで１つ取得する
    @random_message = Message.limit(1).offset(rand(Message.count)).first
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :is_public, :spend_time)
  end

  def ensure_post
    @post = Post.find_by_id(params[:id])
    unless @post
      redirect_to root_path
    end
  end

end
