class CreateAdminComments < ActiveRecord::Migration
  def change
    create_table :admin_comments,options:"charset=utf8" do |t|
      t.integer :from
      t.integer :to
      t.text :content
      t.string :email
      t.string :visitname
      t.string :visiturl
      t.integer :user_id
      t.integer :message_id
      t.integer :supcomment_id
      t.timestamps null: false
    end
  end
end
