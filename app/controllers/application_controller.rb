class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #allow these methods to be used in the views as well
  helper_method :current_user, :logged_in?, :already_voted_by_user?, :vote_object, :already_bookmarked_by_user?, :bookmark_object, :already_commented_by_user?
  
  def current_user
    #if there's an authenticated user, return the user obj
    #else return nil
    #
    #uses memoization to stop the database being hit every time current_user method is called.  
    #If it's the first call then the database is hit and subsequent calls will use the value stored in the @current_user instance variable
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  #takes the current_user method and turns it into a boolean.  !!nil returns false 
  def logged_in?
    !!current_user 
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to do that"
      redirect_to root_path
    end
  end
  
  def already_commented_by_user?(obj)
    !obj.comments.where(:user_id == current_user.id).empty?
  end
  
  def already_voted_by_user?(obj)
    !obj.votes.where(:user_id == current_user.id).empty?
  end
  
  def vote_object(obj)
    obj.votes.where(:user_id == current_user.id).first.id
  end
  
  def already_bookmarked_by_user?
    !current_user.saved_posts.where(:user_id == current_user.id).empty?
  end
  
  def bookmark_object
    current_user.saved_posts.where(:user_id == current_user.id).first.id
  end
end