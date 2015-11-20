class Admin::Message < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags,join_table: 'admin_messages_tags'
  belongs_to :category

  def add_tag(tagName)
    current_tag = tags.find_by_name(tagName)
    if current_tag.nil?
      tag = Admin::Tag.create(name:tagName)
      self.tags<<tag
    end
  end
end
