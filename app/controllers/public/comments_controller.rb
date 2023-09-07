class Public::CommentsController < ApplicationController
  
  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = post.id
    if comment.save
    redirect_to post_path(post)
    else
      flash.now[:notice] = "コメントの保存に失敗しました。"
      render 'public/posts/show', post: post
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    post = comment.post
    if comment.destroy
      redirect_to post_path(post), notice: "コメントの削除に成功しました。"
    else
      flash.now[:notice] = "コメントの削除に失敗しました。"
      render 'public/posts/show', post: post
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
