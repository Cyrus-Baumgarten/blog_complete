class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(params[:post])
    @post.save
    redirect_to posts_path
  end

  def edit
  end

  def update
  end

  def delete
  end
end
