class RelationshipsController < ApplicationController

  def create
    user = User.find(params[:user_id])
    following = current_user.relationships.new
    following.follower_id = user.id
    following.save
    redirect_to users_path
  end

  def destroy
    user = User.find(params[:user_id])
    following = current_user.relationships.find_by(follower_id: user.id)
    following.destroy
    redirect_to users_path
  end
end
