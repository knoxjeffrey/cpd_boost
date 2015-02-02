class AddImageUrlColumnToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :image_url, :string
  end
end
