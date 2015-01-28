class CommentsController < ApplicationController
  
  before_action :require_user
  
  def create
    @post = Post.find_by(slug: params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.creator = current_user
    
    if @comment.save
      flash[:notice] = "You successfully submitted your comment."
      redirect_to post_path(@post)
    else
      render 'posts/show'      
    end
  end
  
  def destroy
    @post = Post.find_by(slug: params[:post_id])
    @comment = Comment.find_by(post_id: @post.id, user_id: current_user.id)
    @comment.destroy
  
    respond_to do |format|
      format.html do
        redirect_to :back
      end
      format.js {}
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end
  
end