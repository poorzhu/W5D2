class PostsController < ApplicationController
  before_action :require_logged_in

  def new
    @post = Post.new
    @subs = Sub.all
  end

  def create
    # debugger
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.sub_id = params[:post][:sub_ids].first.to_i
    # ??? HOW TO GET SUB_ID

    if @post.save

      params[:post][:sub_ids].each do |sub|
        PostSub.create(post_id: @post.id, sub_id: sub)
      end

      redirect_to sub_url(@post.sub_id)
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
    params.require(:post).permit(:title, :url, :content, :sub_id, sub_ids: [])
  end
  
end
