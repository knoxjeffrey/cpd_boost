class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, :url, :description, :slug
      
      t.timestamps
    end
  end
end
