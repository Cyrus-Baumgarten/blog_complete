class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    redirect_to @user
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end
  
end
