class PostsController < ApplicationController
  
  before_filter :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.all
    @comment = Comment.new
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
      if @post.save
        flash[:success] = "Post Created"
        redirect_to @post
      else
        flash.now[:error] = "Post invalid"
        render 'new'
      end
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
      
      if @post.update_attributes(params[:post])
        flash[:success] = "Post updated!"
        redirect_to @post
      else
        flash.now[:error] = "Update is invalid"
        render 'edit'
      end
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
