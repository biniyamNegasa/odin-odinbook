class UsersController < ApplicationController
  before_action :set_user, only: %i[ show followees followers posts ]

  def index
    @users = User.all
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
