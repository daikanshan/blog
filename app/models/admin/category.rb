class Admin::Category < ActiveRecord::Base
  has_and_belongs_to_many :messages,join_table: 'admin_messages_categories'
  validates :name,presence:true

  def subcategories
    Admin::Category.where(father_id:id)
  end
  def supcategory
    Admin::Category.find_by_id(father_id)
  end
end
