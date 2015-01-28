class VotesController < ApplicationController
  
  before_action :set_vote_params, only: [:create, :destroy]
  
  def create
    @vote = Vote.create(voteable: @post, creator: current_user)
    
    respond_to do |format|
      format.html do
        redirect_to :back
      end
      format.js { render 'change' }
    end
  end
  
  def destroy
    @vote = Vote.find_by(voteable: @post, creator: current_user)
    @vote.destroy
  
    respond_to do |format|
      format.html do
        redirect_to :back
      end
      format.js { render 'change' }
    end
  end
  
  private
  
  def set_vote_params
    @post = Post.find_by(slug: params[:post_id])
  end

end
