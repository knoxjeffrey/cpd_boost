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
    @post.creator = current_user
    
    if @post.save
      flash[:notice] = "You successfully created your post!"
      redirect_to posts_path
    else
      render :new
    end
  end
  
  def show
    @post = Post.find_by(slug: params[:id])
    @comment = Comment.new
  end
  
  def edit
    @post = Post.find_by(slug: params[:id])
  end
  
  def update
    @post = Post.find_by(slug: params[:id])
      
    if @post.update(post_params)
      flash[:notice] = "You successfully updated your post!"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end
  
  #all comments associated with post are automatically destroyed by dependent: :destroy in model
  def destroy
    @post = Post.find_by(slug: params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private
  
  def post_params
    params.require(:post).permit(:title, :url, :description)
  end
  
end
