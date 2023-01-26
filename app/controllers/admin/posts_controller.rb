class Admin::PostsController < ApplicationController

  def index
    @posts = Post.all.page(params[:page]).per(8)
  end

  def show
    @post = Post.find(params[:id])
  end

end
