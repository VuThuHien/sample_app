class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def index
    @user = User.find_by id: params[:user_id]
    if @user
      @title = params[:format]
      @users = @user.send(@title).paginate page: params[:page]
      render "show_follow"
    else
      flash[:danger] = "User not found."
      redirect_to root_url
    end
  end

  def create
    user = User.find_by id: params[:followed_id]
    if user
      current_user.follow user
      respond_to do |format|
        format.html {redirect_to @user}
        format.js
        end
    else
      flash[:danger] = "User not found."
    end
  end

  def destroy
    relationship = Relationship.find_by(id: params[:id]).followed
    if relationship
    current_user.unfollow relationship
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
      end
    else
      flash[:danger] = "Haven't follow"
    end
  end
end
