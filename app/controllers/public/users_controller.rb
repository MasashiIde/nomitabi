class Public::UsersController < ApplicationController

  def show
    @user= User.find(params[:id])
    @posts= @user.posts
  end

  def edit
    @user= User.find(params[:id])
  end

  def update
    @user= User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def unsubscribe
  end

  def withdraw
  end

  private

  def user_params
    params.require(:user).permit(:family_name, :first_name, :profile_image, :nickname, :email, :introduction)
  end

end
