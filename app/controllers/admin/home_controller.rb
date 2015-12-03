class Admin::HomeController < AdminController
  def index
    @messages = Admin::Message.all
    @tags = Admin::Tag.all
    @categories = Admin::Category.all
    @comments = Admin::Comment.all
  end
end
