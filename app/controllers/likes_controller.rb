class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post.likes.create(user: current_user)
    redirect_back fallback_location: root_path
  end

  def destroy
    @post = Post.find(params[:post_id])
    @post.likes.find_by(user: current_user).destroy
    redirect_back fallback_location: root_path
  end
end
