class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to request.referer, notice: "コメントの削除に成功しました"
    else
      flash.now[:alert] = "削除に失敗しました"
      redirect_to request.referer
    end
  end

end
