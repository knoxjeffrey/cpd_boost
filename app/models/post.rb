class Post < ActiveRecord::Base
  include Sluggable
  
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  
  has_many :comments, dependent: :destroy #removes all associated comments automatically
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :bookmarked_posts
  has_many :users, through: :bookmarked_posts
  has_many :votes, as: :voteable
    
  validates :title, presence: true, uniqueness: true, length: {minimum: 5}
  validates :description, presence: true
  
  #used in the sluggable_knoxjeffrey gem to create a slug based on the name column
  sluggable_column :title
  
  #check if a comment has already been made by a user
  def already_commented_by_user?(the_user)
    self.comments.where(["user_id = ?", the_user.id]).present?
  end
  
  ########## VOTE ########## 
  #check if a user has already voted on a post
  def voted_by_user?(the_user)
    vote_object(the_user).present?
  end
  
  #return the vote object
  def vote_object(the_user)
    vote_object = the_user.votes.where(["voteable_id = ? and voteable_type = ?", self.id, self.class.name])
    vote_object.present? ? vote_object.first.id : false
  end
  ##########  END VOTE ##########
  
  
  ########## BOOKMARK ##########
  #check if a user has already bookmarked a post
  def bookmarked_by_user?(the_user)
    bookmark_object(the_user).present?
  end
  
  #return the bookmark object
  def bookmark_object(the_user)
    the_user.bookmarked_posts.find_by_post_id(self.id)
  end
  ##########  END BOOKMARK ##########
  
end