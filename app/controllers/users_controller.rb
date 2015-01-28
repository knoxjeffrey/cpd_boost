class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You have successfully registered!  Welcome to PostIt #{current_user.username}."
      redirect_to root_path
    else
      render :new
    end
  end
  
  def show
    
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def bookmark
    @post = Post.find_by(slug: params[:id])
    @bookmark = SavedPost.create(creator: current_user, post_id: @post.id)
    
    respond_to do |format|
      format.html do
        redirect_to :back
      end
      format.js { render 'change' }
    end
  end
  
  def remove_bookmark
    @post = Post.find_by(slug: params[:id])
    @bookmark = SavedPost.find_by(creator: current_user, post_id: @post.id)
    @bookmark.destroy
    
    render 'change'
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :email, :time_zone, :password)
  end
  
end