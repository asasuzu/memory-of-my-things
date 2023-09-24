class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to admin_reports_path, notice: "削除に成功しました"
    else
      flash.now[:alert] = "削除に失敗しました"
      render template: "public/posts/show"
    end
  end

end
