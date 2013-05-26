class StaticPagesController < ApplicationController
  def home
    @post = Post.first
  end
  
  def about
  end
end
