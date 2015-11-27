class Front::SearchController < FrontController
  def index
    @search_messages = Admin::Message.where("title like ?",params[:search])
    @search_users = Admin::User.where("username like ?",params[:search])
    @search_tags = Admin::Tag.where("name like ?",params[:search])
    @search_categories = Admin::Category.where("name like ?",params[:search])
  end
end
