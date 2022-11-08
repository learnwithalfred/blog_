class UsersController < ApplicationController
  def index
    @users = User.order(created_at: :asc)
  end

  def show
    @user = User.find(params[:id])
    @posts = User.find(params[:id]).posts
    @recent_posts = @user.recent_posts
  end

  def posts
    @user = User.find(params[:id])
    @posts = Post.where(author_id: params[:id])
    @comments = @posts
  end

  def post_details
    @user = User.find(params[:id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
    @like = @post.likes.build
  end
end
