class UsersController < ApplicationController
  
  def toggle
    if current_user.anonymous? and current_user.name?
      current_user.update_attributes(anonymous: false)
      flash[:success] = "Your comments are now credited to your username"
      redirect_to :back
    elsif current_user.name? == false
      current_user.update_attributes(anonymous: false)
      flash[:error] = "You need a username to have your comments credited (I never display your email address)"
      redirect_to edit_user_path(current_user)
    elsif current_user.anonymous == false
      current_user.update_attributes(anonymous: true)
      flash[:success] = "Your comments and profile are now anonymous"
      redirect_to :back
    end
  end
  
  def show
    @user = User.find(params[:id]) 
    unless current_user == @user or current_user.admin?
      if @user.anonymous?
        flash[:error] = "This users profile is private"
        redirect_to root_path
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    unless current_user == @user or current_user.admin?
      flash[:error] = "You are not authorized to do that"
      redirect_to root_path
    end
  end
  
  def update
    @user = User.find(params[:id])
    if current_user == @user or current_user.admin?
      @user.update_attributes(params[:user])
      redirect_to @user
    else
      flash[:error] = "You are not authorized to do that"
      redirect_to root_path
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    if current_user == @user or current_user.admin?    
      @user.destroy
      redirect_to root_path
    else
      flash[:error] = "You are not authorized to do that"
      redirect_to root_path
    end
  end
end
