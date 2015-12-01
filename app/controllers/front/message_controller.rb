class Front::MessageController < FrontController

  def index
  end

  def show_tag_messages
    @messages = Admin::Tag.find_by_name(params[:tagname]).messages.order("created_at DESC") if !params[:tagname].nil?
    @type = "tag"
    @name = params[:tagname]
    render :index
  end

  def show_category_messages
    @messages = Admin::Category.find_by_name(params[:categoryname]).messages.order("created_at DESC") if !params[:categoryname].nil?
    @type = "category"
    @name = params[:categoryname]
    render :index
  end

  def show_user_messages
    @messages = Admin::User.find_by_username(params[:username]).messages.order("created_at DESC") if !params[:username].nil?
    @type = "user"
    @name = params[:username]
    render :index
  end

  def show
    @message = Admin::Message.find_by_title(params[:title])
    @comments = @message.comments
    @name = params[:title]
    @type = "message"
  end
end
