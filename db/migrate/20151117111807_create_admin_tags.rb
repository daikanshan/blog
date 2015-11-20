class CreateAdminTags < ActiveRecord::Migration
  def change
    create_table :admin_tags,options:"charset=utf8" do |t|
      t.string :name
      t.string :code
      t.integer :weight

      t.timestamps null: false
    end
  end
end
