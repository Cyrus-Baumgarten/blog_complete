class CommentsController < ApplicationController
  
  before_filter :authenticate_user!, only: [ :create, :edit, :update, :destroy ]
  
  def create
    @post = Post.find(params[:comment][:post_id])
    @comment = @post.comments.build(body: params[:comment][:body])
    @comment.user = current_user
    @comment.save
    redirect_to @post
  end

  def edit
    @comment = Comment.find(params[:id])
    unless user_signed_in? and (current_user.admin? or current_user == @comment.user)
      flash[:error] = "You are not authorized to do that"
      redirect_to root_path
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if user_signed_in? and (current_user.admin? or current_user == @comment.user)
      @comment.update_attributes(body: params[:comment][:body])
      redirect_to post_path(@comment.post)
    else
      flash[:error] = "You are not authorized to do that"
      redirect_to root_path
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if user_signed_in? and (current_user.admin? or current_user == @comment.user)
      @post = @comment.post
      @comment.destroy
      redirect_to @post
    else
      flash[:error] = "You are not authorized to do that"
      redirect_to root_path
    end
  end
end
