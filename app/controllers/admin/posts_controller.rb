class Admin::PostsController < ApplicationController
  
  before_action :authenticate_admin!
  
  def index
    @posts = Post.all.page(params[:page]).per(8)
  end

  def show
    @post = Post.find(params[:id])
  end

end
