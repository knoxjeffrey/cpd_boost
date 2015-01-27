class Post < ActiveRecord::Base
  include Sluggable
  
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :saved_posts
  has_many :users, through: :saved_posts
  has_many :votes, as: :voteable
    
  validates :title, presence: true, uniqueness: true, length: {minimum: 5}
  validate :description, presence: true
  
  #used in the sluggable_knoxjeffrey gem to create a slug based on the name column
  sluggable_column :title
  
end