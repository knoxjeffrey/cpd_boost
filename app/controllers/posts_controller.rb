class PostsController < ApplicationController
  
  before_action :set_post_params, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show] #shut down routes if a user isn't logged in
  before_action :must_be_creator, only: [:edit, :update, :destroy]
  
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
    @comment = Comment.new
  end
  
  def edit; end
  
  def update
      
    if @post.update(post_params)
      flash[:notice] = "You successfully updated your post!"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end
  
  #all comments associated with post are automatically destroyed by dependent: :destroy in model
  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private
  
  def set_post_params
    @post = Post.find_by(slug: params[:id])
  end
  
  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end
  
  def must_be_creator
    access_denied unless logged_in? and (current_user == @post.creator || current_user.admin?)
  end
  
end
