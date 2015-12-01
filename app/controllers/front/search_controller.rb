class Front::SearchController < FrontController
  def index
    @search_messages = Admin::Message.where("title like ?",params[:search]).order("created_at DESC")
    @search_users = Admin::User.where("username like ?",params[:search]).order("created_at DESC")
    @search_tags = Admin::Tag.where("name like ?",params[:search]).order("created_at DESC")
    @search_categories = Admin::Category.where("name like ?",params[:search]).order("created_at DESC")
  end
end
