class Public::HomesController < ApplicationController
  def top
    @posts = Post.public_and_newest.page(params[:page]).per(4)
  end
end
