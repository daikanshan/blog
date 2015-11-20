class CreateAdminMessages < ActiveRecord::Migration
  def change
    create_table :admin_messages,options:"charset=utf8" do |t|
      t.string :title
      t.text :content
      t.string :abstract
      t.string :author
      t.string :tag
      t.string :category
      
      t.integer :user_id
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
