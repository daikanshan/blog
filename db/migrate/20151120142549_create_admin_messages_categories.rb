class CreateAdminMessagesCategories < ActiveRecord::Migration
  def change
    create_table :admin_messages_categories, id:false do |t|
      t.integer :message_id
      t.integer :category_id
    end
  end
end
