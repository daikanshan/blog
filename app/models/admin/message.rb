class Admin::Message < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags,join_table: 'admin_messages_tags'
  has_and_belongs_to_many :categories,join_table: 'admin_messages_categories'
  has_many :comments
  validates :title,presence:true
  validates :content,presence:true
  def add_tag(tagName)
    current_tag = Admin::Tag.find_by_name(tagName)
    if current_tag.nil?#数据库没有该tag则创建并加入
      current_tag = Admin::Tag.create(name:tagName)
      tags<<current_tag
    else#数据库已有该tag
      if !tags.find_by_id(current_tag.id) #文章不包含该tag 则加入
        tags<<current_tag
      end
    end
  end

  def remove_tag(tagName)
    current_tag = Admin::Tag.find_by_name(tagName)
    tags.delete(self)
  end

  def add_category(categoryName)
    current_category = Admin::Category.find_by_name(categoryName)
    if current_category.nil?
      return
    else
      begin
        categories<<current_category
        father_id = current_category.father_id
        current_category = Admin::Category.find_by_id(father_id)
      end while !father_id.nil?
    end
  end
  def remove_category(categoryName)
    current_category = Admin::Category.find_by_name(categoryName)
    if current_category.nil?
      return
    else
      begin
        categories.delete(current_category)
        father_id = current_category.father_id
        current_category = Admin::Category.find_by_id(father_id)
      end while !father_id.nil?
    end
  end
end
