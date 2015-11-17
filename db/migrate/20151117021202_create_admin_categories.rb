class CreateAdminCategories < ActiveRecord::Migration
  def change
    create_table :admin_categories,options:"charset=utf8" do |t|
      t.string :name
      t.string :code

      t.timestamps null: false
    end
  end
end
