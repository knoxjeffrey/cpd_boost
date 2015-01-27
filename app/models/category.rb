class Category < ActiveRecord::Base
  include Sluggable
  
  has_many :post_categories
  has_many :posts, through: :post_categories
  
  validates :name, presence: true, uniqueness: true, length: {minimum: 2}
  
  #used in the sluggable_knoxjeffrey gem to create a slug based on the name column
  sluggable_column :name
end