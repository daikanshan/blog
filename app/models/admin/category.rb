class Admin::Category < ActiveRecord::Base
  has_and_belongs_to_many :messages,join_table: 'admin_messages_categories'
  validates :name,presence:true
end
