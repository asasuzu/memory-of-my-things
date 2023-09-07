class Public::FlowersController < ApplicationController
  before_action :find_post, only: [:create, :destroy]

  def create
    flower = current_user.flowers.new(post_id: @post.id)
    flower.save
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
