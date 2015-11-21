class Admin::IndexController < AdminController
  def index
    @admin_messages = Admin::Message.all
    @admin_categories = Admin::Category.all
    @admin_tags = Admin::Tag.all
  end
end
