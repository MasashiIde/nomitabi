class Public::UsersController < ApplicationController

  before_action :ensure_guest_user, only: [:edit]
  before_action :authenticate_user!

  def index
    @users = User.where.not(id: current_user.id).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(8)
    if @user.status == "nonreleased" && @user != current_user
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def unsubscribe
    @user = User.find_by(email: params[:email])
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行しました"
    redirect_to root_path
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
    @favorite_posts = Kaminari.paginate_array(@favorite_posts).page(params[:page]).per(8)
  end
  
  def search
    @users = User.search(params[:keyword]).page(params[:page]).per(10)
    @keyword = params[:keyword]
    render 'search'
  end
  
  def release
    user = User.find(params[:user_id])
    user.released! unless user.released?
    redirect_to edit_user_path(user), notice: "ユーザーを公開しました"
  end
  
  def nonrelease
    user = User.find(params[:user_id])
    user.nonreleased! unless user.nonreleased?
    redirect_to edit_user_path(user), notice: "ユーザーを非公開にしました"
  end

  private

  def user_params
    params.require(:user).permit(:family_name, :first_name, :profile_image, :nickname, :email, :introduction, :status, :is_deleted)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

end
