class CreateAdminUsers < ActiveRecord::Migration
  def change
    create_table :admin_users,options:"charset=utf8" do |t|
      t.string :username
      t.string :realname
      t.string :password_digest
      t.string :email
      
      t.timestamps null: false
    end
  end
end
