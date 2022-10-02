class RelationshipsController < ApplicationController

  def create
    user = User.find(params[:user_id])
    following = current_user.relationships.new
    following.follower_id = user.id
    following.save
    redirect_to request.referer
  end

  def destroy
    user = User.find(params[:user_id])
    following = current_user.relationships.find_by(follower_id: user.id)
    following.destroy
    redirect_to request.referer
  end

  def followings
    @user = User.find(params[:user_id])
    @followings = @user.followings.all
  end

  def followers
    @user = User.find(params[:user_id])
    @followers = @user.followers.all
  end
end
