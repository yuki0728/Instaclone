class RelationshipsController < ApplicationController
  def create
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    follow.after_save
    redirect_to users_path
  end

  def destroy
    follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
    follow.destroy
    redirext_to root_path
  end
end
