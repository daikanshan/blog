class Admin::Tag < ActiveRecord::Base
  has_and_belongs_to_many :messages,join_table: 'admin_messages_tags'
end
