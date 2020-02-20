require 'time'
class PostsController < ApplicationController
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    @post.user_id = current_user.id
    @post.save
    if @post.wall_id == @post.user_id
      redirect_to user_page_path(current_user.id)
    else
      redirect_to posts_path
    end 
  end

  def index
    posts_all = Post.all
    @posts = []
    posts_all.each do |post|
      if post.user_id == post.wall_id || post.wall_id.nil?
        @posts.push(post)
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id
      @post.destroy
    else
      flash[:notice] = "Thats not your post to delete"
    end
    redirect_to posts_path
  end

  def edit
    @post = Post.find(params[:id])
    logic = @post.user_id == current_user.id
    redirect_to posts_path, notice: "This is not your post to update" unless logic
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(params[:post].permit(:message))
      redirect_to posts_url
    else
      render 'edit'
    end
  end

  private

  def post_params
    params.require(:post).permit(:message, :wall_id)
  end
end
