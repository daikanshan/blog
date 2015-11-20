class CreateAdminMessagesTags < ActiveRecord::Migration
  def change
    create_table :admin_messages_tags, id:false do |t|
      t.integer :message_id
      t.integer :tag_id
    end
  end
end
