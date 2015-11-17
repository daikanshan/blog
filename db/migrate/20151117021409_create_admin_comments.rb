class CreateAdminComments < ActiveRecord::Migration
  def change
    create_table :admin_comments,options:"charset=utf8" do |t|
      t.integer :from
      t.integer :to
      t.text :content

      t.timestamps null: false
    end
  end
end
