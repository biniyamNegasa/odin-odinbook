class UsersController < ApplicationController
  before_action :set_user, only: %i[ show followees followers posts ]

  def index
    @users = User.where.not(id: current_user.followees.pluck(:followee_id)).where.not(id: current_user.id)
  end

  def show
  end

  def followees
    @followees = @user.followees
  end

  def followers
    @followers = @user.followers
  end

  def posts
    @posts = @user.posts.order(created_at: :desc)
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end
