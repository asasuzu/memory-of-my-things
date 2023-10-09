class Public::HomesController < ApplicationController
  def top
    @posts = Post.public_and_newest.limit(8)
  end
end
