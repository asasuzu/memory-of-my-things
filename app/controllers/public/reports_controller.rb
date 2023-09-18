class Public::ReportsController < ApplicationController
  before_action :ensure_reported_item, only: [:new, :create]

  def new
    @report = @item_type.reports.new
  end

  def create
    @report = @item_type.reports.new(report_params)
    @report.user_id = current_user.id
    if @report.save
      redirect_to post_path(@post),
      notice: (params[:comment_id].present? ? "コメントを通報しました。" : "投稿を通報しました。")
    else
      render :new
    end
  end

  private

# 通報のタイプ（コメントor投稿）を確認＆ @post と @comment を設定するメソッド
  def ensure_reported_item
    @item_type = params[:comment_id].present? ? Comment.find(params[:comment_id]) : Post.find(params[:post_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:comment_id]) if params[:comment_id].present?
  end

  def report_params
    params.require(:report).permit(:reason, :reported_item_type, :reported_item_id)
  end
end
