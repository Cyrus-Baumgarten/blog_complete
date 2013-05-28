class CommentsController < ApplicationController
  respond_to :js
  before_filter :authenticate_user!, only: [ :create, :edit, :update, :destroy ]
  
  def create
    @post = Post.find(params[:comment][:post_id])
    @comment = @post.comments.build(body: params[:comment][:body])
    @comment.user = current_user
    if @comment.save
      @comments = @post.comments.all
      respond_with(:location => post_path(@post))
    else
      flash[:error] = "Comment is too long"
      redirect_to @post
    end
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
      if @comment.update_attributes(body: params[:comment][:body])
        flash[:success] = "Comment updated!"
        redirect_to post_path(@comment.post)
      else
        flash.now[:error] = "Comment is invalid"
        render 'edit'
      end
    else
      flash[:error] = "You are not authorized to do that"
      redirect_to root_path
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if user_signed_in? and (current_user.admin? or current_user == @comment.user)
      @post = @comment.post
      @comment_id = @comment.id
      @comment.destroy
      respond_with(@comment_id, :location => post_path(@post))
    else
      flash[:error] = "You are not authorized to do that"
      redirect_to root_path
    end
  end
end
