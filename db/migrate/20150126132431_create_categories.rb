class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, :slug
      
      t.timestamps
    end
  end
end
