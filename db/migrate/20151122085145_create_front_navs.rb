class CreateFrontNavs < ActiveRecord::Migration
  def change
    create_table :front_navs,options:"charset=utf8" do |t|
      t.string :text
      t.integer :user_id
      t.string :url
      t.string :icon
      t.integer :shown
      t.string :code
      t.references :supnav
      t.integer :weight
      t.integer :level

      t.timestamps null: false
    end
  end
end
