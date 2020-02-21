require 'time'
class PostsController < ApplicationController
  
  def new
    @post = Post.new
    session[:my_previous_url] = URI(request.referer || '').path
  
  end

  def create
    @post = Post.create(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to session[:my_previous_url]
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
      redirect_back fallback_location: @post
    else
      flash[:notice] = "Thats not your post to delete!!!"
    end
  end

  def edit
    @post = Post.find(params[:id])
    session[:my_previous_url] = URI(request.referer || '').path
    logic = @post.user_id == current_user.id
    redirect_to session[:my_previous_url], notice: "This is not your post to update!!!" unless logic
  end

  def update
    @post = Post.find(params[:id])     
    if @post.update(params[:post].permit(:message))
      redirect_to session[:my_previous_url]
    else
      render 'edit'
    end
  end

  private

  def post_params
    params.require(:post).permit(:message, :wall_id)
  end
 
end
