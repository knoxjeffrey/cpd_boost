class Post < ActiveRecord::Base
  include Sluggable
  
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  
  has_many :comments, dependent: :destroy #removes all associated comments automatically
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :bookmarked_posts
  has_many :users, through: :saved_posts
  has_many :votes, as: :voteable
    
  validates :title, presence: true, uniqueness: true, length: {minimum: 5}
  validates :description, presence: true
  
  #used in the sluggable_knoxjeffrey gem to create a slug based on the name column
  sluggable_column :title
  
  #check if a comment has already been made by a user
  def already_commented_by_user?(current_user)
    !self.comments.where(["user_id = ?", current_user.id]).empty?
  end
  
  ########## VOTE ########## 
  #check if a user has already voted on a post
  def already_voted_by_user?(current_user)
    post_vote_array(current_user).present?
  end
  
  #return the id of the vote after it's confirmed that a user has already voted on a post
  def vote_object(current_user)
    post_vote_array(current_user).first.id
  end
  
  def post_vote_array(current_user)
    self.votes.where(["user_id = ? and voteable_id = ? and voteable_type = ?", current_user.id, self.id, self.class.name])
  end
  ##########  END VOTE ##########
  
  
  ########## BOOKMARK ##########
  #check if a user has already bookmarked a post
  def already_bookmarked_by_user?(current_user)
    post_bookmark_array(current_user).present?
  end
  
  #return the id of the bookmark after it's confirmed that a user has already bookmarked on a post
  def bookmark_object(current_user)
    post_bookmark_array(current_user).first.id
  end
  
  def post_bookmark_array(current_user)
    current_user.bookmarked_posts.where(["user_id = ? and post_id = ?", current_user.id, self.id])
  end
  ##########  END BOOKMARK ##########
  
end