class User < ActiveRecord::Base
  include Sluggable
  
  has_many :comments
  has_many :posts
  has_many :bookmarked_posts
  has_many :votes
  
  has_secure_password validations: false
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}
  
  #used in the sluggable_knoxjeffrey gem to create a slug based on the name column
  sluggable_column :username
  
  def admin?
    self.role == 'admin'
  end
  
  def moderator?
    self.role == 'moderator'
  end
  
  def list_of_user_saved_posts
    self.bookmarked_posts.map { |saved| saved.post }
  end
  
end