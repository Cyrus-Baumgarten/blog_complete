class PostsController < ApplicationController
  
  before_filter :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.all
    @comment = @post.comments.build
  end

  def new
    if user_signed_in? and current_user.admin?
      @post = current_user.posts.build
    else
      flash[:error] = "You are not authorized to do that"
      redirect_to root_path
    end
  end

  def create
    if user_signed_in? and current_user.admin?
      @post = current_user.posts.build(params[:post])
      @post.save
      redirect_to @post
    else
      flash[:error] = "You are not authorized to do that"
      redirect_to root_path
    end
  end

  def edit
    if user_signed_in? and current_user.admin?
      @post = Post.find(params[:id])
    else
      flash[:error] = "You are not authorized to do that"
      redirect_to root_path
    end
  end

  def update
    if user_signed_in? and current_user.admin?
      @post = Post.find(params[:id])
      @post.update_attributes(params[:post])
      redirect_to @post
    else
      flash[:error] = "You are not authorized to do that"
      redirect_to root_path
    end
  end

  def destroy
    if user_signed_in? and current_user.admin?
      @post = Post.find(params[:id])
      @post.destroy
      redirect_to posts_path
    else
      flash[:error] = "You are not authorized to do that"
      redirect_to root_path
    end
  end
end
