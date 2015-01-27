class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :slug
      t.string :role
      t.string :time_zone
      t.string :password_digest
      
      t.timestamps
    end
  end
end
