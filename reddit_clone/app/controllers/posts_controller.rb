class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    # ??? HOW TO GET SUB_ID

    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find_by(id: params[:id], user_id: current_user.id)

  end

  def update
    @post = Post.find_by(id: params[:id], user_id: current_user.id)

    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.delete
    redirect_to subs_url
  end

  private

  def post_params
    pararms.require(:post).permit(:title, :url, :content)
  end
  
end
