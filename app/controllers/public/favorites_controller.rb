class Public::FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    Favorite.create(user_id: current_user.id, post_id: @post.id)
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = Favorite.find_by(user_id: current_user.id, post_id: @post.id)
    favorite.destroy
  end

end