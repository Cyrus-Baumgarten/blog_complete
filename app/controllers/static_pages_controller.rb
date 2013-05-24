class StaticPagesController < ApplicationController
  def home
    @post = Post.first
  end

  def landing
  end

  def about
  end
end
