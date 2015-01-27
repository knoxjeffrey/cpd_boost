class CreateSavedPosts < ActiveRecord::Migration
  def change
    create_table :saved_posts do |t|
      t.integer :user_id, :post_id
      
      t.timestamps
    end
  end
end
