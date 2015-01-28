class ChangeSavedPostsTableName < ActiveRecord::Migration
  def change
    rename_table :saved_posts, :bookmarked_posts
  end
end
