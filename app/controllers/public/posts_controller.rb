class Public::PostsController < ApplicationController
  
  before_action :ensure_guest_user, except: [:index, :show, :search]
  before_action :authenticate_user!
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def index
    @posts = Post.all.page(params[:page]).per(12)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def search
    @posts = Post.search(params[:keyword]).page(params[:page]).per(12)
    @keyword = params[:keyword]
    render "search"
  end

  private

  def post_params
    params.require(:post).permit(:shop_image, :shop_name, :introduction, :shop_address, :shop_url)
  end
  
  def ensure_guest_user
    if current_user.email == "guest@example.com"
      redirect_to posts_path
    end
  end

end
