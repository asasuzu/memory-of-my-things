class Public::FlowersController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]
  before_action :find_post

  def create
    if user_signed_in?
      flower = current_user.flowers.new(post_id: @post.id)
      flower.save
    else
      redirect_to new_user_session_path, alert: "ログインもしくはアカウント登録をしてください。"
    end
  end

  def destroy
    flower = current_user.flowers.find_by(post_id: @post.id)
    flower.destroy
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

end
