class UsersController < ApplicationController
  
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
