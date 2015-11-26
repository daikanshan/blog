class Front::SearchController < FrontController
  def index
    @messages = Admin::Message.where("title like ?",params[:search])
    @users = Admin::User.where("username like ?",params[:search])
    @tags = Admin::Tag.where("name like ?",params[:search])
    @categories = Admin::Category.where("name like ?",params[:search])
  end
end
