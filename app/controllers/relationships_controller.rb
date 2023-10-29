class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
  # ↑フォロー機能
  
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer  
  end
  # ↑フォロー外し機能
end
