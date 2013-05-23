class CommentsController < ApplicationController
  
  def create
    @post = Post.find(params[:comment][:post_id])
    @comment = @post.comments.build(body: params[:comment][:body])
    @comment.user = current_user
    @comment.save
    redirect_to @post
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update_attributes(body: params[:comment][:body])
    redirect_to post_path(@comment.post)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comment.destroy
    redirect_to @post
  end
end
