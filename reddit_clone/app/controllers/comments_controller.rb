class CommentsController < ApplicationController
  before_action :require_logged_in

  def new
    debugger
    @comment = Comment.new(post_id: params[:post_id])
  end

  def create
    debugger
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_to post_url(@post)
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id, :parent_comment_id)
  end
end
