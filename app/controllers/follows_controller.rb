class FollowsController < ApplicationController
  def create
    @followee = User.find(params[:id])
    @followee.followers.append(current_user)
    redirect_back fallback_location: root_path, notice: "You are now following #{@followee.username}"
  end

  def destroy
    @followee = User.find(params[:id])
    current_user.followees.delete(@followee)
    redirect_back fallback_location: root_path, alert: "You are no longer following #{@followee.username}"
  end
end
