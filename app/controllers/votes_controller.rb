class VotesController < ApplicationController
  
  def create
    @post = Post.find_by(slug: params[:post_id])
    @vote = Vote.create(voteable: @post, creator: current_user)
    
    respond_to do |format|
      format.html do
        redirect_to :back
      end
      format.js { render 'change' }
    end
  end
  
  def destroy
    @post = Post.find_by(slug: params[:post_id])
    @vote = Vote.find_by(voteable: @post, creator: current_user)
    @vote.destroy
  
    respond_to do |format|
      format.html do
        redirect_to :back
      end
      format.js { render 'change' }
    end
  end

end
