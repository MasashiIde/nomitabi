class Public::PostCommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.post_comments.new(post_comment_params)
    @comment.post_id = @post.id
    if @comment.save
      @post.create_notification_post_comment!(current_user, @comment.id)
      render :post_comments
    else
      render :error
    end
  end

  def destroy
    PostComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    @post = Post.find(params[:post_id])
    render :post_comments
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
