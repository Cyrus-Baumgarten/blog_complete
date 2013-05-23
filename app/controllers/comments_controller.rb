class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:comment][:post_id])
    @comment = @post.comments.build(params[:post])
    @comment.user = current_user
    @comment.save
    redirect_to @post
  end

  def edit
  end

  def update
  end

  def delete
  end
end
