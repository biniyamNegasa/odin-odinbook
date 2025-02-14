class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post.likes.create(user: current_user)
    render partial: "likes/like", locals: { post: @post }
  end

  def destroy
    @post = Post.find(params[:post_id])
    @post.likes.find_by(user: current_user).destroy
    render partial: "likes/like", locals: { post: @post }
  end
end
