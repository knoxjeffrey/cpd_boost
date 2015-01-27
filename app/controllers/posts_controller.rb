class PostsController < ApplicationController
  
  before_action :require_user, except: [:index, :show] #shut down routes if a user isn't logged in
  
  def index
    @posts = Post.all
  end
  
  def new 
    @post = Post.new
  end
  
  def create
    @post = Post.create(post_params)
    
    if @post.save
      flash[:notice] = "You successfully created your post!"
      redirect_to posts_path
    else
      render :new
    end
  end


  private
  
  def post_params
    params.require(:post).permit(:title, :url, :description)
  end
  
end
