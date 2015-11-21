class CreateAdminCategories < ActiveRecord::Migration
  def change
    create_table :admin_categories,options:"charset=utf8" do |t|
      t.string :name
      t.string :code
      t.integer :father_id
      t.integer :weight
      t.integer :level
      t.timestamps null: false
    end
  end
end
